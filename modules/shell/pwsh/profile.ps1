# Perfil de PowerShell Core (pwsh) — ejemplo
Write-Host 'Loading PowerShell profile from dotfiles'
# $Env:EDITOR = 'code'

# Ejemplo de prompt
function global:prompt {
    "PS $(Get-Location)> "
}
