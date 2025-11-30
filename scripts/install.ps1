Param(
    [string[]]$Modules = @(),
    [string]$Target = $env:USERPROFILE
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
$HOME = $Target
$XDG_CONFIG_HOME = if ($env:XDG_CONFIG_HOME) { $env:XDG_CONFIG_HOME } elseif ($env:APPDATA) { $env:APPDATA } else { Join-Path $HOME '.config' }
$XDG_DATA_HOME   = if ($env:XDG_DATA_HOME)   { $env:XDG_DATA_HOME }   elseif ($env:LOCALAPPDATA) { $env:LOCALAPPDATA } else { Join-Path $HOME '.local\share' }
$XDG_STATE_HOME  = if ($env:XDG_STATE_HOME)  { $env:XDG_STATE_HOME }  elseif ($env:LOCALAPPDATA) { $env:LOCALAPPDATA } else { Join-Path $HOME '.local\state' }
    
# Files that should be sanitized (convert CRLF -> LF) when present
$SanitizeBasenames = @('.bashrc', '.profile', '.bash_profile', '.zshrc', '.bash_logout')

function Get-SanitizedPath {
    param(
        [string]$SourcePath,
        [string]$ModuleName
    )
    $base = Split-Path $SourcePath -Leaf
    if ($SanitizeBasenames -contains $base) {
        # Detect CRLF (Carriage Return) in file bytes
        try {
            $bytes = Get-Content -Raw -Encoding Byte -Path $SourcePath -ErrorAction Stop
            if ($bytes -contains 13) {
                $relDir = (Split-Path $SourcePath -Parent).Substring((Join-Path $PSScriptRoot $ModuleName).Length).TrimStart('\')
                $sanDir = Join-Path $Target (Join-Path '.dotfiles_sanitized' (Join-Path $ModuleName $relDir))
                New-Item -ItemType Directory -Force -Path $sanDir | Out-Null
                $sanFile = Join-Path $sanDir $base
                # read as text, remove CR, write as UTF8
                $txt = [IO.File]::ReadAllText($SourcePath)
                $txt = $txt -replace "`r", ''
                [IO.File]::WriteAllText($sanFile, $txt, [System.Text.Encoding]::UTF8)
                return $sanFile
            }
        } catch {
            # fallback: not critical
        }
    }
    return $SourcePath
}

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
    # Also track module-specific relative mappings for exclusion
    $MAPPED_RELS = @{}
    foreach ($k in $MAPPER_MODULE.Keys) {
        $parts = $k -split '\|',2
        $name = $parts[0]
        $mod = $parts[1]
        if ($name -match '[\\/]') { $MAPPED_RELS["$name|$mod"] = $true }
    }

    function Map-Target {
        param($relPath, $moduleName)
        # reset flag
        $script:MAPPING_EXPLICIT = $false
        $base = Split-Path $relPath -Leaf
        # If this is an explicit relative path mapping in the yaml (contains '\'), prefer it
        if ($MAPPER_MODULE.ContainsKey("$relPath|$moduleName")) { $mapping = $MAPPER_MODULE["$relPath|$moduleName"]; $script:MAPPING_EXPLICIT = $true; $script:MAPPING_KEY = "rel:$relPath" }
        elseif ($MAPPER_MODULE.ContainsKey("$base|$moduleName")) { $mapping = $MAPPER_MODULE["$base|$moduleName"]; $script:MAPPING_EXPLICIT = $true; $script:MAPPING_KEY = "base:$base" }
        elseif ($MAPPER_GLOBAL.ContainsKey($relPath)) { $mapping = $MAPPER_GLOBAL[$relPath]; $script:MAPPING_EXPLICIT = $true; $script:MAPPING_KEY = "rel:$relPath" }
        elseif ($MAPPER_GLOBAL.ContainsKey($base)) { $mapping = $MAPPER_GLOBAL[$base]; $script:MAPPING_EXPLICIT = $true; $script:MAPPING_KEY = "base:$base" }
        else { $mapping = $null; $script:MAPPING_KEY = $null }

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
            'error' { $script:MAPPING_EXPLICIT = $false; return '__ERROR__' }
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
        Write-Host "Mapping: $rel => $dest (explicit=$($script:MAPPING_EXPLICIT -eq $true), key=$($script:MAPPING_KEY))" -ForegroundColor Cyan
        if ($dest -eq '__IGNORE__') { continue }
        if ($script:MAPPING_EXPLICIT -ne $true) { continue }
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
            $sanTarget = Get-SanitizedPath -SourcePath $f.FullName -ModuleName (Split-Path $module -Leaf)
            New-Item -ItemType SymbolicLink -Path $dest -Target $sanTarget -Force | Out-Null
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
        # After resolving conflicts, create symlinks for explicit mapping files
        $mapCreated = @()
        foreach ($f in $allFiles) {
            # Determine mapping for this file and skip if marked ignore
            $rel = $f.FullName.Substring($modulePath.Length).TrimStart('\')
            $dest = Map-Target -relPath $rel -moduleName (Split-Path $module -Leaf)
            if ($dest -eq '__IGNORE__') { continue }
            if ($script:MAPPING_EXPLICIT -ne $true) { continue }
            # Always create symlink for explicit mappings (even if path equals default)
            # Ensure the target directory exists
            if ($script:MAPPING_KEY -and ($script:MAPPING_KEY -like 'base:*')) {
                # if multiple files in this module share the same base name, skip ambiguous mapping
                $baseName = $script:MAPPING_KEY -replace '^base:'
                $matches = Get-ChildItem -Path $modulePath -File -Recurse | Where-Object { $_.Name -eq $baseName }
                if ($matches.Count -gt 1) {
                    Write-Warning "Ambiguous mapping: multiple files named $baseName exist in module $module; please use a relative path mapping in install-mappings.yml to disambiguate."
                    continue
                }
            }
            $destDir = Split-Path $dest -Parent
            if (-not (Test-Path $destDir)) { New-Item -ItemType Directory -Force -Path $destDir | Out-Null }
            if (Test-Path $dest) { Remove-Item -Recurse -Force -Path $dest -ErrorAction SilentlyContinue }
            $sanTarget = Get-SanitizedPath -SourcePath $f.FullName -ModuleName (Split-Path $module -Leaf)
            New-Item -ItemType SymbolicLink -Path $dest -Target $sanTarget -Force | Out-Null
            $mapCreated += $dest
            Write-Host "Creado symlink: $dest -> $($f.FullName)" -ForegroundColor Green
        }
        # Phase 2 - create symlinks for non-explicit files according to DEFAULT_ACTION
        $remaining = @()
        foreach ($f in $allFiles) {
            $rel = $f.FullName.Substring($modulePath.Length).TrimStart('\')
            $dest = Map-Target -relPath $rel -moduleName (Split-Path $module -Leaf)
            if ($dest -eq '__IGNORE__') { continue }
            if ($script:MAPPING_EXPLICIT -eq $true) { continue }
            $remaining += $f
        }
        foreach ($f in $remaining) {
            $rel = $f.FullName.Substring($modulePath.Length).TrimStart('\')
            $dest = Map-Target -relPath $rel -moduleName (Split-Path $module -Leaf)
            if ($dest -eq '__IGNORE__') { continue }
            $destDir = Split-Path $dest -Parent
            if (-not (Test-Path $destDir)) { New-Item -ItemType Directory -Force -Path $destDir | Out-Null }
            # If it is a symlink pointing to same target, ignore; else if exists and not same - backup
            $skip = $false
            if (Test-Path $dest) {
                $it = Get-Item -Path $dest -Force -ErrorAction SilentlyContinue
                if ($it -and $it.PSIsContainer -eq $false -and $it.LinkType -ne $null) {
                    $lt = $it.Target
                    if ($lt -and (Resolve-Path $lt -ErrorAction SilentlyContinue).ProviderPath -eq $f.FullName) {
                        $skip = $true
                    }
                }
            }
            if ($skip) { continue }
            if (Test-Path $dest) {
                $backupDir = Join-Path $env:USERPROFILE ".dotfiles_backup\$(Get-Date -UFormat %s)\$module"
                $relPath = $dest.Substring($env:USERPROFILE.Length).TrimStart('\')
                $destPath = Join-Path $backupDir $relPath
                New-Item -ItemType Directory -Force -Path (Split-Path $destPath -Parent) | Out-Null
                Move-Item -Path $dest -Destination $destPath -Force -ErrorAction SilentlyContinue
            }
            $sanTarget = Get-SanitizedPath -SourcePath $f.FullName -ModuleName (Split-Path $module -Leaf)
            New-Item -ItemType SymbolicLink -Path $dest -Target $sanTarget -Force | Out-Null
            $mapCreated += $dest
            Write-Host "Creado symlink (default): $dest -> $($f.FullName)" -ForegroundColor Green
        }
        }
        # After creating mappings, validate
        foreach ($d in $mapCreated) {
            if (-not (Test-Path $d)) { continue }
            $item = Get-Item -Path $d -Force -ErrorAction SilentlyContinue
            if ($item -and $item.LinkType -ne $null) { continue }
            # Not a symlink: backup & recreate
            $backupDir = Join-Path $env:USERPROFILE ".dotfiles_backup\$(Get-Date -UFormat %s)\$module"
            $rel = $d.Substring($env:USERPROFILE.Length).TrimStart('\')
            $destPath = Join-Path $backupDir $rel
            New-Item -ItemType Directory -Force -Path (Split-Path $destPath -Parent) | Out-Null
            Move-Item -Path $d -Destination $destPath -Force -ErrorAction SilentlyContinue
            # Try to recreate symlink
            $fname = Split-Path $d -Leaf
            $found = Get-ChildItem -Path $modulePath -File -Recurse | Where-Object { $_.Name -eq $fname } | Select-Object -First 1
            if ($found) {
                $sanTarget = Get-SanitizedPath -SourcePath $found.FullName -ModuleName (Split-Path $module -Leaf)
                New-Item -ItemType SymbolicLink -Path $d -Target $sanTarget -Force | Out-Null
                Write-Host "Post-stow: Recreated symlink $d -> $($found.FullName)" -ForegroundColor Green
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
