<#
SYNOPSIS
  Restore files backed up by the dotfiles installer (PowerShell).

USAGE
  .\scripts\restore-backup.ps1                # list available backups
  .\scripts\restore-backup.ps1 -Timestamp <timestamp>    # list modules in the backup
  .\scripts\restore-backup.ps1 -Timestamp <timestamp> -Module <module>  # restore module
#>

param(
  [string]$Timestamp,
  [string]$Module,
  [switch]$WhatIf
)

$BackupDir = Join-Path $HOME ".dotfiles_backup"

function Show-Help {
  Write-Output "Uso:`n  .\scripts\restore-backup.ps1`n  .\scripts\restore-backup.ps1 -Timestamp <timestamp> -Module <module>`n"
}

if (-not $Timestamp) {
  if (Test-Path $BackupDir) {
    "Backups disponibles:"; Get-ChildItem -Path $BackupDir -Directory | ForEach-Object { $_.Name }
  } else {
    Write-Warning "No se encontraron respaldos en: $BackupDir"
  }
  exit 0
}

$TimestampDir = Join-Path $BackupDir $Timestamp
if (-not (Test-Path $TimestampDir -PathType Container)) {
  Write-Error "Marca de tiempo del backup no encontrada: $Timestamp"; exit 2
}

if (-not $Module) {
  Write-Host "Módulos en el backup $($Timestamp):"; Get-ChildItem -Path $TimestampDir -Directory | ForEach-Object { $_.Name }
  exit 0
}

$Src = Join-Path $TimestampDir $Module
if (-not (Test-Path $Src -PathType Container)) {
  Write-Error "Módulo no encontrado en el backup: $Module"; exit 3
}

Write-Host "A punto de restaurar el módulo '$Module' del backup '$Timestamp' a $HOME"
$confirm = Read-Host "¿Proceder y sobrescribir archivos en $HOME? [s/N]"
if ($confirm -ne 'y' -and $confirm -ne 'Y' -and $confirm -ne 'yes' -and $confirm -ne 's' -and $confirm -ne 'S' -and $confirm -ne 'si' -and $confirm -ne 'SI') {
  Write-Host "Abortado. No se realizaron cambios."; exit 0
}

# Prefer robocopy or Copy-Item depending on availability
if (Get-Command robocopy -ErrorAction SilentlyContinue) {
  $cmd = "robocopy `"$Src`" `"$HOME`" /E /COPY:DAT /MT:4"
  if ($WhatIf) { Write-Host "Simulación: $cmd"; exit 0 }
  iex $cmd | Out-Null
} else {
  if ($WhatIf) { Write-Host "Simulación: Copy-Item -Recurse -Force $Src \$HOME"; exit 0 }
  Copy-Item -Path (Join-Path $Src '*') -Destination $HOME -Recurse -Force
}

Write-Host "Restauración completada."
Exit 0
