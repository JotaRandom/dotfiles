Param(
    [string]$Package = ''
)

$target = "distros/PKGBUILD"
if ($Package -ne '') { $target = Join-Path $target $Package }
if (-not (Test-Path $target)) { Write-Host "Directorio destino $target no encontrado"; exit 1 }

Get-ChildItem -Path $target -Directory | ForEach-Object {
    $d = $_.FullName
    if (Test-Path (Join-Path $d '.git')) {
        Write-Host "Actualizando $($_.Name)..."
        git -C $d fetch --all
        try { git -C $d pull --ff-only } catch { git -C $d pull }
        git add $d
    }
}
try { git commit -m "chore: update PKGBUILD submodules" } catch { Write-Host "No hay cambios para commitear" }
Write-Host "Listo. Verifica con 'git status' y sube tu rama." -ForegroundColor Green
