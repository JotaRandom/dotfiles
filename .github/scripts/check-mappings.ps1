param(
    [Parameter(ValueFromRemainingArguments=$true)]
    $RemainingArgs
)
$script = Join-Path $PSScriptRoot 'check-mappings.sh'
$bash = Get-Command bash -ErrorAction SilentlyContinue
if ($bash) {
    & $bash $script @RemainingArgs
    exit $LASTEXITCODE
}
Write-Error "Este script requiere 'bash' (instala Git for Windows o habilita WSL)." 
exit 2
