Param(
    [string]$Package = ''
)

$target = "distros/PKGBUILD"
if ($Package -ne '') { $target = Join-Path $target $Package }
if (-not (Test-Path $target)) { Write-Host "Target $target not found"; exit 1 }

Get-ChildItem -Path $target -Directory | ForEach-Object {
    $d = $_.FullName
    if (Test-Path (Join-Path $d '.git')) {
        Write-Host "Updating $($_.Name)..."
        git -C $d fetch --all
        try { git -C $d pull --ff-only } catch { git -C $d pull }
        git add $d
    }
}
try { git commit -m "chore: update PKGBUILD submodules" } catch { Write-Host "No changes to commit" }
Write-Host "Done. Verify with 'git status' and push your branch." -ForegroundColor Green
