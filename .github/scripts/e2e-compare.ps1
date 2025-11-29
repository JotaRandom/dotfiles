<#
End-to-end installer verification (Windows / PowerShell)
# (Copied into .github/scripts for CI-only usage)
#>

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$RepoRoot = (git rev-parse --show-toplevel 2>$null) -or '.'
$Mappings = Join-Path $RepoRoot 'install-mappings.yml'
if (-not (Test-Path $Mappings)) { Write-Error "install-mappings.yml not found at $Mappings"; exit 1 }

$tmpRoot = [IO.Path]::Combine($env:TEMP, [System.Guid]::NewGuid().ToString())
New-Item -ItemType Directory -Path $tmpRoot | Out-Null

$homeTmp = Join-Path $tmpRoot 'UserProfile'
$cfgTmp = Join-Path $tmpRoot 'Config'
$stateTmp = Join-Path $tmpRoot 'State'
$dataTmp = Join-Path $tmpRoot 'Data'
$cacheTmp = Join-Path $tmpRoot 'Cache'
foreach ($d in @($homeTmp,$cfgTmp,$stateTmp,$dataTmp,$cacheTmp)) { New-Item -ItemType Directory -Path $d | Out-Null }

Write-Host "Using temp root: $tmpRoot"

# prepare env for install.ps1
$env:USERPROFILE = $homeTmp
$env:XDG_CONFIG_HOME = $cfgTmp
$env:XDG_STATE_HOME = $stateTmp
$env:XDG_DATA_HOME = $dataTmp
$env:XDG_CACHE_HOME = $cacheTmp

Push-Location $RepoRoot

# run installer for all modules
$modules = Get-ChildItem -Path modules -Directory -Recurse -Depth 2 | Where-Object { $_.FullName -match 'modules\\[^\\]+\\[^\\]+' } | ForEach-Object { $_.FullName }
& pwsh -NoProfile -ExecutionPolicy Bypass -File .\scripts\install.ps1 -Modules $modules

Write-Host "Listing symlinks created in temp profile/XDG dirs..."
Get-ChildItem -Path $homeTmp,$cfgTmp,$stateTmp,$dataTmp,$cacheTmp -Recurse -Force -ErrorAction SilentlyContinue | Where-Object { $_.LinkType -ne $null -and $_.Target -like "$RepoRoot*modules*" } | ForEach-Object { Write-Host "$_ -> $($_.Target)" }

exit 0
