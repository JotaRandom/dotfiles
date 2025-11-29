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

    # Map target path for a module relative file (respect XDG where applicable)
    function Map-Target {
        param($relPath, $moduleName)
        # nested paths -> keep relative under HOME
        if ($relPath -match '\\') { return Join-Path $HOME $relPath }
        # dotfile already? place under HOME directly
        if ($relPath -match '^\.') { return Join-Path $HOME $relPath }
        switch -regex ($relPath) {
            '^config\.fish$' { return Join-Path $XDG_CONFIG_HOME 'fish\\config.fish' }
            '^init\.vim$'     { return Join-Path $XDG_CONFIG_HOME 'nvim\\init.vim' }
            '^settings\.json$' {
                if ($moduleName -match 'vscode') { return Join-Path $XDG_CONFIG_HOME 'Code\\User\\settings.json' }
                if ($moduleName -match 'micro')  { return Join-Path $XDG_CONFIG_HOME 'micro\\settings.json' }
                return Join-Path $HOME $relPath
            }
            '^config\.json$' { if ($moduleName -match 'micro') { return Join-Path $XDG_CONFIG_HOME 'micro\\config.json' } else { return Join-Path $HOME $relPath } }
            '^init\.el$'     { if ($moduleName -match 'emacs') { return Join-Path $HOME '.emacs.d\\init.el' } else { return Join-Path $HOME $relPath } }
            '^config\.toml$' {
                if ($moduleName -match 'helix') { return Join-Path $XDG_CONFIG_HOME 'helix\\config.toml' }
                if ($moduleName -match 'nushell') { return Join-Path $XDG_CONFIG_HOME 'nushell\\config.toml' }
                return Join-Path $HOME $relPath
            }
            '^kakrc$' { return Join-Path $XDG_CONFIG_HOME 'kak\\kakrc' }
            '^kateconfig$' { return Join-Path $XDG_CONFIG_HOME 'kate\\kateconfig' }
            '^gedit-settings\.xml$' { return Join-Path $XDG_CONFIG_HOME 'gedit\\gedit-settings.xml' }
            '^chrome-flags\.conf$' { return Join-Path $XDG_CONFIG_HOME 'chrome\\chrome-flags.conf' }
            default { return Join-Path $HOME ('.' + $relPath) }
        }
    }

    # Phase 1 - collect all files and detect conflicts
    $allFiles = Get-ChildItem -Path $modulePath -File -Recurse
    $conflicts = @()
    foreach ($f in $allFiles) {
        # Skip README and module docs — not intended to be linked into $HOME
        if ($f.Name -ieq 'README.md') { continue }
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
            # Skip README and module docs — not intended to be linked into $HOME
            if ($f.Name -ieq 'README.md') { continue }
            $rel = $f.FullName.Substring($modulePath.Length).TrimStart('\\')
            $dest = Map-Target -relPath $rel -moduleName (Split-Path $module -Leaf)
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
