param(
    [Parameter(ValueFromRemainingArguments=$true)]
    $RemainingArgs
)
# Hook pre-push para PowerShell: delega a git-lfs si está disponible
if (-not (Get-Command git-lfs -ErrorAction SilentlyContinue)) {
    Write-Error "Este repositorio está configurado para Git LFS pero 'git-lfs' no se encontró en tu PATH. Si ya no deseas usar Git LFS, elimina este hook (.githooks/pre-push)";
    exit 2
}
& git lfs pre-push @RemainingArgs
exit $LASTEXITCODE
