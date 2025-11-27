Param(
    [string]$AssetsPath = "assets/poni",
    [string]$OutFile = "assets/poni/ATTRIBUTIONS.md"
)

if (-not (Test-Path $AssetsPath)) { Write-Host "No existe $AssetsPath"; exit 1 }

$header = @"
Lista de atribuciones de `$AssetsPath`

Este archivo contiene una lista de imágenes y su atribución (si está disponible). Si conoces la fuente o la licencia de una imagen, por favor abre un PR con esa información.

Formato:
- `nombre_de_archivo.ext` — Nombre del autor o fuente (licencia)

Listado:

"@

$files = Get-ChildItem -Path $AssetsPath -File | Sort-Object Name | ForEach-Object { "- " + $_.Name + " - Autor desconocido (Licencia desconocida)" }

$header + ($files -join "`n") | Out-File -FilePath $OutFile -Encoding UTF8

Write-Host ("Generado {0} con {1} entradas" -f $OutFile, ($files).Count)
