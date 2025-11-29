# PowerShell pre-commit hook: ensure scripts/*.sh are executable in the index
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
    Write-Host "Marked staged files with shebang as executable in index"
}
exit 0