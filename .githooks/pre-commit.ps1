# Hook pre-commit para PowerShell: asegurar que scripts/*.sh sean ejecutables en el índice
param()

# Get staged files
$staged = git diff --cached --name-only --diff-filter=ACM
if (-not $staged) { exit 0 }

$changed = $false
foreach ($f in $staged) {
    if (Test-Path $f) {
        $firstLine = Get-Content -Path $f -TotalCount 1 -ErrorAction SilentlyContinue
        if ($firstLine -and $firstLine -match '^#!') {
            git update-index --chmod=+x $f
            $changed = $true
        }
    }
}
if ($changed) {
    Write-Host "Se marcaron archivos con shebang como ejecutables en el índice"
}
exit 0