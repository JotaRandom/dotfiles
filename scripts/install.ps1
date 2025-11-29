Param(
    [string[]]$Modules = @()
)

function Test-GitLFS {
    [CmdletBinding()]
    param()

    if (-not (Get-Command git-lfs -ErrorAction SilentlyContinue)) {
        Write-Warning "git-lfs no encontrado. Instálalo con 'winget', 'scoop' o manualmente."
        return $false
    }
    return $true
}

if ($Modules.Count -eq 0) {
    $Modules = @('modules/shell/bash','modules/shell/zsh','modules/apps/tmux','modules/apps/xmms')
}

# XDG fallback variables (Windows: prefer APPDATA / LOCALAPPDATA but respect XDG vars if set)
$HOME = $env:USERPROFILE
$XDG_CONFIG_HOME = if ($env:XDG_CONFIG_HOME) { $env:XDG_CONFIG_HOME } elseif ($env:APPDATA) { $env:APPDATA } else { Join-Path $HOME '.config' }
$XDG_DATA_HOME   = if ($env:XDG_DATA_HOME)   { $env:XDG_DATA_HOME }   elseif ($env:LOCALAPPDATA) { $env:LOCALAPPDATA } else { Join-Path $HOME '.local\share' }
$XDG_STATE_HOME  = if ($env:XDG_STATE_HOME)  { $env:XDG_STATE_HOME }  elseif ($env:LOCALAPPDATA) { $env:LOCALAPPDATA } else { Join-Path $HOME '.local\state' }

if (-not (Test-GitLFS)) {
    Write-Warning "git-lfs no disponible; algunas características (LFS) pueden no funcionar"
}

foreach ($module in $Modules) {
    $modulePath = Join-Path $PSScriptRoot $module
    if (-not (Test-Path $modulePath)) {
        Write-Host "Advertencia: módulo $modulePath no existe" -ForegroundColor Yellow
        continue
    }
    # Safety: skip modules that contain system-level paths (etc/) — installer doesn't touch /etc
    if (Get-ChildItem -Path $modulePath -Recurse -File | Where-Object { $_.FullName -like '*\\etc\\*' }) {
        Write-Host "Skipping module $modulePath because it contains system-level files under 'etc/'." -ForegroundColor Yellow
        continue
    }

    # Parse install-mappings.yml (YAML-lite) so this installer is mapping-driven
    $MAPPINGS_FILE = Join-Path $PSScriptRoot '..\install-mappings.yml'
    $MAPPER_GLOBAL = @{}
    $MAPPER_MODULE = @{}
    $DEFAULT_ACTION = 'dotify'
    if (Test-Path $MAPPINGS_FILE) {
        Get-Content $MAPPINGS_FILE | ForEach-Object {
            $line = $_ -replace '#.*',''    # strip comments
            $line = $line.Trim()
            if ([string]::IsNullOrWhiteSpace($line)) { return }
            if ($line -match '^default_action:\s*(\w+)') { $DEFAULT_ACTION = $matches[1]; return }
            if ($line -match '^([^:]+):\s*(.+)$') {
                $k = $matches[1].Trim()
                $v = $matches[2].Trim()
                if ($k -like '*|*') {
                    $parts = $k -split '\|',2
                    $name = $parts[0].Trim()
                    $mod  = $parts[1].Trim()
                    $MAPPER_MODULE["$name|$mod"] = $v
                } else {
                    $MAPPER_GLOBAL[$k] = $v
                }
            }
        }
    }

    # Build set of root-level mapped filenames for this repo (used to influence behavior)
    $MAPPED_NAMES = @{}
    foreach ($k in $MAPPER_GLOBAL.Keys) { $MAPPED_NAMES[$k] = $true }
    foreach ($k in $MAPPER_MODULE.Keys) { $name = $k -split '\|',2 | Select-Object -First 1; $MAPPED_NAMES[$name] = $true }

    function Map-Target {
        param($relPath, $moduleName)
        # if this is a nested path (contains backslash), default to HOME/<relPath>
        if ($relPath -match '\\') { return Join-Path $HOME $relPath }

        $base = Split-Path $relPath -Leaf

        # check module-specific mapping first
        if ($MAPPER_MODULE.ContainsKey("$base|$moduleName")) { $mapping = $MAPPER_MODULE["$base|$moduleName"] }
        elseif ($MAPPER_GLOBAL.ContainsKey($base)) { $mapping = $MAPPER_GLOBAL[$base] }
        else { $mapping = $null }

        if ($mapping) {
            if ($mapping -in @('ignore','skip')) { return '__IGNORE__' }
            if ($mapping -like 'xdg:*') {
                $sub = $mapping.Substring(4) -replace '/','\\'
                return Join-Path $XDG_CONFIG_HOME $sub
            }
            if ($mapping -like 'xdg_state:*') {
                $sub = $mapping.Substring(10) -replace '/','\\'
                return Join-Path $XDG_STATE_HOME $sub
            }
            if ($mapping -like 'xdg_data:*') {
                $sub = $mapping.Substring(9) -replace '/','\\'
                return Join-Path $XDG_DATA_HOME $sub
            }
            if ($mapping -like 'xdg_cache:*') {
                $sub = $mapping.Substring(10) -replace '/','\\'
                return Join-Path $env:LOCALAPPDATA $sub
            }
            if ($mapping -like 'home:*') {
                $sub = $mapping.Substring(5) -replace '/','\\'
                return Join-Path $HOME $sub
            }
            # no prefix — treat mapping as path relative to HOME
            $sub = $mapping -replace '/','\\'
            return Join-Path $HOME $sub
        }

        # No mapping: follow DEFAULT_ACTION
        switch ($DEFAULT_ACTION) {
            'dotify' {
                if ($base -match '^\.') { return Join-Path $HOME $base }
                else { return Join-Path $HOME ('.' + $base) }
            }
            'home' { return Join-Path $HOME $base }
            'error' { return '__ERROR__' }
            default {
                if ($base -match '^\.') { return Join-Path $HOME $base }
                else { return Join-Path $HOME ('.' + $base) }
            }
        }
    }

    # Phase 1 - collect all files and detect conflicts
    $allFiles = Get-ChildItem -Path $modulePath -File -Recurse
    $conflicts = @()
    foreach ($f in $allFiles) {
        # Determine mapping for this file and skip if install-mappings.yml marks it as ignore
        $rel = $f.FullName.Substring($modulePath.Length).TrimStart('\')
        $dest = Map-Target -relPath $rel -moduleName (Split-Path $module -Leaf)
        if ($dest -eq '__IGNORE__') { continue }
        $rel = $f.FullName.Substring($modulePath.Length).TrimStart('\\')
        $dest = Map-Target -relPath $rel -moduleName (Split-Path $module -Leaf)
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
            New-Item -ItemType SymbolicLink -Path $dest -Target $f.FullName -Force | Out-Null
            Write-Host "Creado symlink: $dest -> $($f.FullName)" -ForegroundColor Green
        }
    }
        if ($conflicts.Count -gt 0) {
            $join = $conflicts -join "`n"
            Write-Host "Conflictos detectados para módulo ${module}:`n$join" -ForegroundColor Yellow
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
            # Determine mapping for this file and skip if marked ignore
            $rel = $f.FullName.Substring($modulePath.Length).TrimStart('\')
            $dest = Map-Target -relPath $rel -moduleName (Split-Path $module -Leaf)
            if ($dest -eq '__IGNORE__') { continue }
            $destDir = Split-Path $dest -Parent
            if (-not (Test-Path $destDir)) { New-Item -ItemType Directory -Force -Path $destDir | Out-Null }
            if (Test-Path $dest) { Remove-Item -Recurse -Force -Path $dest -ErrorAction SilentlyContinue }
            New-Item -ItemType SymbolicLink -Path $dest -Target $f.FullName -Force | Out-Null
            Write-Host "Creado symlink: $dest -> $($f.FullName)" -ForegroundColor Green
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
