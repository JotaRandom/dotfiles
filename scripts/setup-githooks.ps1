# PowerShell setup to configure Git hooks path
param()

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Error "git not found"
    exit 1
}

git config core.hooksPath .githooks
Write-Host "core.hooksPath set to .githooks"

# Make sure the Windows scripts are executable in index (call the PS pre-commit logic)
# Only set execute bit for scripts with a shebang
$files = git ls-files "scripts/*.sh" 2>$null
foreach ($f in $files) {
    if (Test-Path $f) {
        $firstLine = Get-Content -Path $f -TotalCount 1 -ErrorAction SilentlyContinue
        if ($firstLine -and $firstLine -match '^#!') {
            git update-index --chmod=+x $f
        }
    }
}

Write-Host "Updated git index for scripts/*.sh to be executable (if present)."
