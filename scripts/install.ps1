Param(
    [string[]]$Modules = @(),
    [switch]$Force,
    [switch]$NoBackup,
    [switch]$DryRun
)

function Ensure-GitLFS {
    if (-not (Get-Command git-lfs -ErrorAction SilentlyContinue)) {
        Write-Host "git-lfs no encontrado. Intenta instalar con "winget" o "scoop" o instala manualmente" -ForegroundColor Yellow
    }
}

if ($Modules.Count -eq 0) {
    $Modules = @('modules/shell/bash','modules/shell/zsh','modules/apps/tmux','modules/apps/xmms')
}

Ensure-GitLFS

foreach ($module in $Modules) {
    $modulePath = Join-Path $PSScriptRoot $module
    if (-not (Test-Path $modulePath)) {
        Write-Host "Advertencia: módulo $modulePath no existe" -ForegroundColor Yellow
        continue
    }
    # Detect conflicts: for each file in module, compute target path
    $conflicts = @()
    Get-ChildItem -Path $modulePath -File -Recurse | ForEach-Object {
        $rel = $_.FullName.Substring($modulePath.Length).TrimStart('\')
        $dest = Join-Path $env:USERPROFILE $rel
        $destDir = Split-Path $dest -Parent
        if (-not (Test-Path $destDir)) { New-Item -ItemType Directory -Force -Path $destDir | Out-Null }
        if (Test-Path $dest) {
            # if it is a symlink pointing to the same source, ignore
            if ((Test-Path $dest -PathType Leaf) -or (Test-Path $dest -PathType Container)) {
                $isSame = $false
                try { 
                    $linkTarget = (Get-Item -Path $dest -Force).Target
                    if ($linkTarget -and (Resolve-Path $linkTarget).ProviderPath -eq $_.FullName) { $isSame = $true }
                } catch { }
                if (-not $isSame) { $conflicts += $dest }
            } else { $conflicts += $dest }
        } else {
            New-Item -ItemType SymbolicLink -Path $dest -Target $_.FullName -Force | Out-Null
            Write-Host "Creado symlink: $dest -> $($_.FullName)" -ForegroundColor Green
        }
    }
    if ($conflicts.Count -gt 0) {
        Write-Host "Conflictos detectados para módulo $module:`n$($conflicts -join "`n")" -ForegroundColor Yellow
        if ($DryRun) {
            Write-Host "(Dry-run) no se aplicarán cambios" -ForegroundColor Yellow
            continue
        }
        if ($Force) {
            Write-Host "Forzando sobrescritura (se eliminarán los archivos existentes)" -ForegroundColor Yellow
            foreach ($c in $conflicts) { Remove-Item -Recurse -Force -Path $c -ErrorAction SilentlyContinue }
        } elseif (-not $NoBackup) {
            $backupDir = Join-Path $env:USERPROFILE ".dotfiles_backup\$(Get-Date -UFormat %s)\$module"
            Write-Host "Respaldando archivos conflictivos a: $backupDir" -ForegroundColor Cyan
            foreach ($c in $conflicts) {
                $destPath = Join-Path $backupDir ($c.TrimStart($env:USERPROFILE+'\'))
                $destDir = Split-Path $destPath -Parent
                New-Item -ItemType Directory -Force -Path $destDir | Out-Null
                Move-Item -Path $c -Destination $destPath -Force -ErrorAction SilentlyContinue
            }
        } else {
            Write-Host "Omitiendo la instalación del módulo $module por conflictos" -ForegroundColor Yellow
            continue
        }
        # After resolving, create the symlinks again for the module
        Get-ChildItem -Path $modulePath -File -Recurse | ForEach-Object {
            $rel = $_.FullName.Substring($modulePath.Length).TrimStart('\')
            $dest = Join-Path $env:USERPROFILE $rel
            $destDir = Split-Path $dest -Parent
            if (-not (Test-Path $destDir)) { New-Item -ItemType Directory -Force -Path $destDir | Out-Null }
            if (Test-Path $dest) { Remove-Item -Recurse -Force -Path $dest -ErrorAction SilentlyContinue }
            New-Item -ItemType SymbolicLink -Path $dest -Target $_.FullName -Force | Out-Null
            Write-Host "Creado symlink: $dest -> $($_.FullName)" -ForegroundColor Green
        }
    }
}

Write-Host "Instalación (PowerShell) finalizada. Revisa los enlaces simbólicos." -ForegroundColor Cyan

# Auto-configure Git hooks in this repository (safe and idempotent)
try {
    $null = git rev-parse --is-inside-work-tree 2>$null
    $setupPath = Join-Path $PSScriptRoot 'setup-githooks.ps1'
    if (Test-Path $setupPath) {
        Write-Host "Configurando hooks de git localmente (core.hooksPath -> .githooks)" -ForegroundColor Cyan
        try { & $setupPath } catch { Write-Warning "No se pudo configurar hooks de git: $_" }
    }
} catch {
    # Not a git repository or git not available; ignore
}
