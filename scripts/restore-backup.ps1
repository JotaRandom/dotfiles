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
  Write-Output "Usage:`n  .\scripts\restore-backup.ps1`n  .\scripts\restore-backup.ps1 -Timestamp <timestamp> -Module <module>`n"
}

if (-not $Timestamp) {
  if (Test-Path $BackupDir) {
    "Available backups:"; Get-ChildItem -Path $BackupDir -Directory | ForEach-Object { $_.Name }
  } else {
    Write-Warning "No backups found at: $BackupDir"
  }
  exit 0
}

$TimestampDir = Join-Path $BackupDir $Timestamp
if (-not (Test-Path $TimestampDir -PathType Container)) {
  Write-Error "Backup timestamp not found: $Timestamp"; exit 2
}

if (-not $Module) {
  Write-Host "Modules in backup $($Timestamp):"; Get-ChildItem -Path $TimestampDir -Directory | ForEach-Object { $_.Name }
  exit 0
}

$Src = Join-Path $TimestampDir $Module
if (-not (Test-Path $Src -PathType Container)) {
  Write-Error "Module not found in backup: $Module"; exit 3
}

Write-Host "About to restore module '$Module' from backup '$Timestamp' to $HOME"
$confirm = Read-Host "Proceed and overwrite files in $HOME? [y/N]"
if ($confirm -ne 'y' -and $confirm -ne 'Y' -and $confirm -ne 'yes') {
  Write-Host "Aborted. No files changed."; exit 0
}

# Prefer robocopy or Copy-Item depending on availability
if (Get-Command robocopy -ErrorAction SilentlyContinue) {
  $cmd = "robocopy `"$Src`" `"$HOME`" /E /COPY:DAT /MT:4"
  if ($WhatIf) { Write-Host "WhatIf: $cmd"; exit 0 }
  iex $cmd | Out-Null
} else {
  if ($WhatIf) { Write-Host "WhatIf: Copy-Item -Recurse -Force $Src \$HOME"; exit 0 }
  Copy-Item -Path (Join-Path $Src '*') -Destination $HOME -Recurse -Force
}

Write-Host "Restore complete."
Exit 0
