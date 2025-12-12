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
    $Modules = @(
        'modules/shell/bash','modules/shell/zsh','modules/shell/fish','modules/shell/ksh',
        'modules/shell/tcsh','modules/shell/mksh','modules/shell/elvish','modules/shell/xonsh',
        'modules/shell/pwsh','modules/apps/tmux','modules/apps/xmms','modules/windowing/x11',
        'modules/pacman','modules/desktop/chrome','modules/git','modules/editor/nvim',
        'modules/editor/vscode','modules/editor/emacs','modules/editor/vim','modules/editor/nano',
        'modules/editor/latex','modules/terminal/alacritty','modules/terminal/kitty'
    )
}

# Variables XDG por defecto (Windows: preferir APPDATA / LOCALAPPDATA, respetar variables XDG si están definidas)
$HOME = $Target
$XDG_CONFIG_HOME = if ($env:XDG_CONFIG_HOME) { $env:XDG_CONFIG_HOME } elseif ($env:APPDATA) { $env:APPDATA } else { Join-Path $HOME '.config' }
$XDG_DATA_HOME   = if ($env:XDG_DATA_HOME)   { $env:XDG_DATA_HOME }   elseif ($env:LOCALAPPDATA) { $env:LOCALAPPDATA } else { Join-Path $HOME '.local\share' }
$XDG_STATE_HOME  = if ($env:XDG_STATE_HOME)  { $env:XDG_STATE_HOME }  elseif ($env:LOCALAPPDATA) { $env:LOCALAPPDATA } else { Join-Path $HOME '.local\state' }
    
# Archivos que deben ser saneados (convertir CRLF -> LF) cuando estén presentes
$SanitizeBasenames = @('.bashrc', '.profile', '.bash_profile', '.zshrc', '.bash_logout')

function Get-SanitizedPath {
    param(
        [string]$SourcePath,
        [string]$ModuleName
    )
    $base = Split-Path $SourcePath -Leaf
    if ($SanitizeBasenames -contains $base) {
        # Detectar CRLF (Carriage Return) en los bytes del archivo
        try {
            $bytes = Get-Content -Raw -Encoding Byte -Path $SourcePath -ErrorAction Stop
            if ($bytes -contains 13) {
                $relDir = (Split-Path $SourcePath -Parent).Substring((Join-Path $PSScriptRoot $ModuleName).Length).TrimStart('\')
                $sanDir = Join-Path $Target (Join-Path '.dotfiles_sanitized' (Join-Path $ModuleName $relDir))
                New-Item -ItemType Directory -Force -Path $sanDir | Out-Null
                $sanFile = Join-Path $sanDir $base
                # leer como texto, eliminar CR y escribir como UTF-8
                $txt = [IO.File]::ReadAllText($SourcePath)
                $txt = $txt -replace "`r", ''
                [IO.File]::WriteAllText($sanFile, $txt, [System.Text.Encoding]::UTF8)
                return $sanFile
            }
        } catch {
                # fallback: no crítico
        }
    }
    return $SourcePath
}

if (-not (Test-GitLFS)) {
    Write-Warning "git-lfs no disponible; algunas características (LFS) pueden no funcionar"
}

# Resolver la raíz del repositorio y asegurarnos de operar desde ella (permitir ejecución desde cualquier CWD)
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$RepoRoot = ''
try {
    $gitTop = git rev-parse --show-toplevel 2>$null
    if ($gitTop) { $RepoRoot = $gitTop.Trim() }
} catch { }
if (-not $RepoRoot) {
    $RepoRoot = (Resolve-Path (Join-Path $ScriptDir '..')).ProviderPath
}
Set-Location -Path $RepoRoot

# Normalizar entradas de Modules a rutas absolutas dentro del repo
for ($i=0; $i -lt $Modules.Count; $i++) {
    $entry = $Modules[$i]
    if ([System.IO.Path]::IsPathRooted($entry)) {
        $Modules[$i] = $entry
    } else {
        $Modules[$i] = Join-Path $RepoRoot $entry
    }
}

foreach ($module in $Modules) {
    $modulePath = Join-Path $PSScriptRoot $module
    if (-not (Test-Path $modulePath)) {
        Write-Host "Advertencia: módulo $modulePath no existe" -ForegroundColor Yellow
        continue
    }
    # Precaución: omitir módulos que contengan rutas a nivel de sistema (p. ej., etc/) — el instalador no toca /etc
    if (Get-ChildItem -Path $modulePath -Recurse -File | Where-Object { $_.FullName -like '*\\etc\\*' }) {
        Write-Host "Omitiendo módulo $modulePath porque contiene archivos a nivel de sistema bajo 'etc/'." -ForegroundColor Yellow
        continue
    }

    # Analizar install-mappings.yml (YAML-lite) para que este instalador sea guiado por mapeos
    $MAPPINGS_FILE = Join-Path $PSScriptRoot '..\install-mappings.yml'
    $MAPPER_GLOBAL = @{}
    $MAPPER_MODULE = @{}
    $DEFAULT_ACTION = 'dotify'
    if (Test-Path $MAPPINGS_FILE) {
            # Leer el fichero completo y soportar listas YAML (clave: \n  - item)
            $mapLines = Get-Content $MAPPINGS_FILE -ErrorAction SilentlyContinue
            for ($i=0; $i -lt $mapLines.Count; $i++) {
                $line = $mapLines[$i]
                $line = ($line -replace '#.*','').Trim()
                if ([string]::IsNullOrWhiteSpace($line)) { continue }
                if ($line -match '^default_action:\s*(\w+)') { $DEFAULT_ACTION = $matches[1]; continue }
                if ($line -match '^([^:]+):\s*(.+)$') {
                    $k = $matches[1].Trim(); $v = $matches[2].Trim()
                } elseif ($line -match '^([^:]+):\s*$') {
                    # clave seguida de lista indentada '-' en las siguientes líneas
                    $k = $matches[1].Trim()
                    $vals = @()
                    $j = $i + 1
                    while ($j -lt $mapLines.Count) {
                        $nxt = ($mapLines[$j] -replace '#.*','').Trim()
                        if ($nxt -match '^-[\s]*(.+)$') {
                            $it = $matches[1].Trim()
                            # re-evaluar matches variable name reuse
                            $it = $nxt -replace '^-[\s]*',''
                            $it = $it.Trim()
                            if ($it -ne '') { $vals += $it }
                            $j++
                            continue
                        }
                        break
                    }
                    $i = $j - 1
                    $v = ($vals -join ',')
                } else {
                    continue
                }
                if ($k -like '*|*') {
                    $parts = $k -split '\|',2
                    $name = $parts[0].Trim(); $mod = $parts[1].Trim()
                    $key = "{0}|{1}" -f $name, $mod
                    if ($MAPPER_MODULE.ContainsKey($key)) { $MAPPER_MODULE[$key] = "$($MAPPER_MODULE[$key]),$v" }
                    else { $MAPPER_MODULE[$key] = $v }
                } else {
                    if ($MAPPER_GLOBAL.ContainsKey($k)) { $MAPPER_GLOBAL[$k] = "$($MAPPER_GLOBAL[$k]),$v" }
                    else { $MAPPER_GLOBAL[$k] = $v }
                }
        }
    }

        # Construir conjunto de nombres de ficheros mapeados a nivel raíz en este repo (usado para influir en el comportamiento)
        $MAPPED_NAMES = @{}
        foreach ($k in $MAPPER_GLOBAL.Keys) {
            $bn = [System.IO.Path]::GetFileName($k)
            if (-not [string]::IsNullOrWhiteSpace($bn)) { $MAPPED_NAMES[$bn] = $true }
        }
        foreach ($k in $MAPPER_MODULE.Keys) {
            $name = ($k -split '\|',2)[0]
            $bn = [System.IO.Path]::GetFileName($name)
            if (-not [string]::IsNullOrWhiteSpace($bn)) { $MAPPED_NAMES[$bn] = $true }
        }
        # También registrar mapeos relativos específicos por módulo para exclusión
        $MAPPED_RELS = @{}
        foreach ($k in $MAPPER_MODULE.Keys) {
            $parts = $k -split '\|',2
            $name = $parts[0]
            $mod = $parts[1]
            if ($name -match '[\\/]') { $MAPPED_RELS["$name|$mod"] = $true }
        }

    function Map-Target {
        param($relPath, $moduleName)
        # restablecer bandera
        $script:MAPPING_EXPLICIT = $false
        $base = Split-Path $relPath -Leaf
        # Si este es un mapeo por ruta relativa explícita en el YAML (contiene '\'), preferirlo
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
            # sin prefijo — tratar el mapeo como ruta relativa a HOME
            $sub = $mapping -replace '/','\\'
            return Join-Path $HOME $sub
        }

        # Sin mapeo: seguir DEFAULT_ACTION
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

    # Fase 1 - coleccionar todos los archivos y detectar conflictos
    $allFiles = Get-ChildItem -Path $modulePath -File -Recurse
    $conflicts = @()
    foreach ($f in $allFiles) {
        # Determinar el mapeo para este archivo y omitir si install-mappings.yml lo marca como 'ignore'
        $rel = $f.FullName.Substring($modulePath.Length).TrimStart('\')
        $dest = Map-Target -relPath $rel -moduleName (Split-Path $module -Leaf)
        Write-Host "Mapeo: $rel => $dest (explícito=$($script:MAPPING_EXPLICIT -eq $true), clave=$($script:MAPPING_KEY))" -ForegroundColor Cyan
        if ($dest -eq '__IGNORE__') { continue }
        if ($script:MAPPING_EXPLICIT -ne $true) { continue }
        $rel = $f.FullName.Substring($modulePath.Length).TrimStart('\\')
        $dest = Map-Target -relPath $rel -moduleName (Split-Path $module -Leaf)
        $destDir = Split-Path $dest -Parent
        if (-not (Test-Path $destDir)) { New-Item -ItemType Directory -Force -Path $destDir | Out-Null }
        if (Test-Path $dest) {
            # si es un enlace simbólico que apunta al mismo destino, omitir; de lo contrario, registrar conflicto
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
        # Tras resolver conflictos, crear enlaces simbólicos para archivos con mapeos explícitos
        $mapCreated = @()
        foreach ($f in $allFiles) {
            # Determinar mapeo para este archivo y omitir si está marcado como 'ignore'
            $rel = $f.FullName.Substring($modulePath.Length).TrimStart('\')
            $dest = Map-Target -relPath $rel -moduleName (Split-Path $module -Leaf)
            if ($dest -eq '__IGNORE__') { continue }
            if ($script:MAPPING_EXPLICIT -ne $true) { continue }
            # Siempre crear enlace simbólico para mapeos explícitos (incluso si la ruta coincide con la predeterminada)
            # Asegurar que el directorio destino exista (crearlo si es necesario)
            if ($script:MAPPING_KEY -and ($script:MAPPING_KEY -like 'base:*')) {
                # si varios archivos en este módulo comparten el mismo nombre base, omitir el mapeo ambiguo
                $baseName = $script:MAPPING_KEY -replace '^base:'
                $matches = Get-ChildItem -Path $modulePath -File -Recurse | Where-Object { $_.Name -eq $baseName }
                if ($matches.Count -gt 1) {
                    Write-Warning "Mapeo ambiguo: existen varios archivos llamados $baseName en el módulo $module; usa un mapeo por ruta relativa en install-mappings.yml para desambiguar."
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
        # Fase 2 - crear enlaces simbólicos para archivos no explícitos según DEFAULT_ACTION
        # y asegurar que los directorios de destino existan (crearlos cuando sea necesario)
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
            # Si es un enlace simbólico que apunta al mismo destino, omitir; si existe y no es el mismo, respaldar
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
        # Tras crear mapeos, validar
        foreach ($d in $mapCreated) {
            if (-not (Test-Path $d)) { continue }
            $item = Get-Item -Path $d -Force -ErrorAction SilentlyContinue
            if ($item -and $item.LinkType -ne $null) { continue }
            # No es un enlace simbólico: respaldar y recrear
            $backupDir = Join-Path $env:USERPROFILE ".dotfiles_backup\$(Get-Date -UFormat %s)\$module"
            $rel = $d.Substring($env:USERPROFILE.Length).TrimStart('\')
            $destPath = Join-Path $backupDir $rel
            New-Item -ItemType Directory -Force -Path (Split-Path $destPath -Parent) | Out-Null
            Move-Item -Path $d -Destination $destPath -Force -ErrorAction SilentlyContinue
            # Intentar recrear el enlace simbólico
            $fname = Split-Path $d -Leaf
            $found = Get-ChildItem -Path $modulePath -File -Recurse | Where-Object { $_.Name -eq $fname } | Select-Object -First 1
            if ($found) {
                $sanTarget = Get-SanitizedPath -SourcePath $found.FullName -ModuleName (Split-Path $module -Leaf)
                New-Item -ItemType SymbolicLink -Path $d -Target $sanTarget -Force | Out-Null
                Write-Host "Post-instalación: recreado enlace simbólico $d -> $($found.FullName)" -ForegroundColor Green
            }
        }

Write-Host "Instalación (PowerShell) finalizada. Revisa los enlaces simbólicos." -ForegroundColor Cyan

# Configurar hooks de Git automáticamente en este repositorio (seguro e idempotente)
try {
    $null = git rev-parse --is-inside-work-tree 2>$null
    $setupPath = Join-Path $PSScriptRoot 'setup-githooks.ps1'
    if (Test-Path $setupPath) {
        Write-Host "Configurando hooks de git localmente (core.hooksPath -> .githooks)" -ForegroundColor Cyan
        try { & $setupPath } catch { Write-Warning "No se pudo configurar hooks de git: $_" }
    }
} catch {
    # No es un repositorio git o git no está disponible; ignorar
}

# --- INICIO DE CAMBIO ---
# Asegurarse de que los submódulos y Git LFS estén inicializados
Write-Host "Inicializando submódulos y Git LFS (si aplica)..." -ForegroundColor Cyan
try {
    git submodule update --init --recursive -Force
    git lfs pull
    Write-Host "Submódulos y Git LFS inicializados correctamente." -ForegroundColor Green
} catch {
    Write-Warning "Advertencia: Falló la inicialización de submódulos o Git LFS. Algunas características pueden no estar disponibles. Error: $_"
}
# --- FIN DE CAMBIO ---
