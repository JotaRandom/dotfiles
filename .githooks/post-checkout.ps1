param(
    [Parameter(ValueFromRemainingArguments=$true)]
    $RemainingArgs
)
# Hook post-checkout para PowerShell: delega a git-lfs si está disponible
if (-not (Get-Command git-lfs -ErrorAction SilentlyContinue)) {
    Write-Error "Este repositorio está configurado para Git LFS pero 'git-lfs' no se encontró en tu PATH. Si ya no deseas usar Git LFS, elimina este hook (.githooks/post-checkout)";
    exit 2
}
& git lfs post-checkout @RemainingArgs
exit $LASTEXITCODE
