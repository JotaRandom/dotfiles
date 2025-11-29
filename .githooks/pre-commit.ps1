# PowerShell pre-commit hook: ensure scripts/*.sh are executable in the index
param()

# Get staged files
$staged = git diff --cached --name-only --diff-filter=ACM
if (-not $staged) { exit 0 }

$changed = $false
foreach ($f in $staged) {
    if ($f -like 'scripts/*.sh') {
        if (Test-Path $f) {
            # Set the executable bit in git index
            git update-index --chmod=+x $f
            $changed = $true
        }
    }
}
if ($changed) {
    Write-Host "Marked staged scripts/*.sh as executable in index"
}
exit 0