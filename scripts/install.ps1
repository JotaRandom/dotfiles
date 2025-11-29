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
    Get-ChildItem -Path $modulePath -File -Recurse | ForEach-Object {
        $rel = $_.FullName.Substring($modulePath.Length).TrimStart('\')
        $dest = Join-Path $env:USERPROFILE $rel
        $destDir = Split-Path $dest -Parent
        if (-not (Test-Path $destDir)) { New-Item -ItemType Directory -Force -Path $destDir | Out-Null }
        if (Test-Path $dest) {
            Write-Host "Omitiendo $dest ya existe" -ForegroundColor Yellow
        } else {
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
