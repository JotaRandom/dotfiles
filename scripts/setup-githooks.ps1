# Script PowerShell para configurar la ruta de hooks de Git
param()

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Error "git no encontrado"
    exit 1
}

git config core.hooksPath .githooks
Write-Host "core.hooksPath configurado a .githooks"

# Asegurarse que los scripts de Windows tengan el bit ejecutable en el índice (llamar a la lógica PS pre-commit)
# Solo establecer el bit de ejecución para scripts que tienen shebang
$files = git ls-files 2>$null
foreach ($f in $files) {
    if (Test-Path $f) {
        $firstLine = Get-Content -Path $f -TotalCount 1 -ErrorAction SilentlyContinue
        if ($firstLine -and $firstLine -match '^#!') {
            git update-index --chmod=+x $f
        }
    }
}

Write-Host "Índice de Git actualizado: scripts/*.sh marcados como ejecutables (si existen)."
