$count = 0
$i = 1
Get-Content scripts/install.ps1 | ForEach-Object {
    $line = $_
    $open = ($line.ToCharArray() | Where-Object { $_ -eq '{' } | Measure-Object).Count
    $close = ($line.ToCharArray() | Where-Object { $_ -eq '}' } | Measure-Object).Count
    $count += $open - $close
    if ($count -lt 0) { Write-Warning "MISMATCH at line $i" }
    Write-Host ("{0:D3}: {1}" -f $i, $line)
    $i++
}
Write-Host "FINAL COUNT: $count"
