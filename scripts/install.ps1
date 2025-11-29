Param(
    [string[]]$Modules = @()
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
    # Phase 1 - collect all files and detect conflicts
    $allFiles = Get-ChildItem -Path $modulePath -File -Recurse
    $conflicts = @()
    foreach ($f in $allFiles) {
        $rel = $_.FullName.Substring($modulePath.Length).TrimStart('\')
        $dest = Join-Path $env:USERPROFILE $rel
        $destDir = Split-Path $dest -Parent
        if (-not (Test-Path $destDir)) { New-Item -ItemType Directory -Force -Path $destDir | Out-Null }
        if (Test-Path $dest) {
            # if it is a symlink pointing to same target, ignore; else record conflict
            $isSame = $false
            try {
                $item = Get-Item -Path $dest -Force -ErrorAction SilentlyContinue
                if ($item -and $item.PSIsContainer -eq $false -and $item.LinkType -ne $null) {
                    $linkTarget = $item.Target
                    if ($linkTarget -and (Resolve-Path $linkTarget -ErrorAction SilentlyContinue).ProviderPath -eq $f.FullName) { $isSame = $true }
                }
            } catch { }
            if (-not $isSame) { $conflicts += $dest }
        } else {
            New-Item -ItemType SymbolicLink -Path $dest -Target $_.FullName -Force | Out-Null
            Write-Host "Creado symlink: $dest -> $($_.FullName)" -ForegroundColor Green
        }
    }
        if ($conflicts.Count -gt 0) {
            Write-Host "Conflictos detectados para módulo $module:`n$($conflicts -join "`n")" -ForegroundColor Yellow
            $backupDir = Join-Path $env:USERPROFILE ".dotfiles_backup\$(Get-Date -UFormat %s)\$module"
            Write-Host "Respaldando archivos conflictivos a: $backupDir" -ForegroundColor Cyan
            foreach ($c in $conflicts) {
                $relPath = $c.Substring($env:USERPROFILE.Length).TrimStart('\')
                $destPath = Join-Path $backupDir $relPath
                $destDir = Split-Path $destPath -Parent
                New-Item -ItemType Directory -Force -Path $destDir | Out-Null
                Move-Item -Path $c -Destination $destPath -Force -ErrorAction SilentlyContinue
            }
        }
        # After resolving conflicts, create symlinks for all files
        foreach ($f in $allFiles) {
            $rel = $f.FullName.Substring($modulePath.Length).TrimStart('\')
            $dest = Join-Path $env:USERPROFILE $rel
            $destDir = Split-Path $dest -Parent
            if (-not (Test-Path $destDir)) { New-Item -ItemType Directory -Force -Path $destDir | Out-Null }
            if (Test-Path $dest) { Remove-Item -Recurse -Force -Path $dest -ErrorAction SilentlyContinue }
            New-Item -ItemType SymbolicLink -Path $dest -Target $f.FullName -Force | Out-Null
            Write-Host "Creado symlink: $dest -> $($f.FullName)" -ForegroundColor Green
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
