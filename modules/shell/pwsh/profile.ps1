# PowerShell Core (pwsh) profile sample
Write-Host 'Loading PowerShell profile from dotfiles'
# $Env:EDITOR = 'code'

# Prompt example
function global:prompt {
    "PS $(Get-Location)> "
}
