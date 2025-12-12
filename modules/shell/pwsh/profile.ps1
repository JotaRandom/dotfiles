# Perfil de PowerShell Core (pwsh) — ejemplo mínimo
Write-Host 'Loading PowerShell profile from dotfiles'
# $Env:EDITOR = 'code'

# Ejemplo de prompt dinámico que muestra ubicación actual
function global:prompt {
    "PS $($executionContext.SessionState.Path.CurrentLocation)> "
}
