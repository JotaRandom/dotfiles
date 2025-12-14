# PowerShell Profile - Optimizado para ThinkPad L420 (1366x768)
# $PROFILE (Microsoft.PowerShell_profile.ps1)

# ===== PROMPT COMPACTO =====
# Prompt de 1 línea
function prompt {
    $user = $env:USERNAME
    $host = $env:COMPUTERNAME
    $path = (Get-Location).Path
    Write-Host "$user@$host" -ForegroundColor Green -NoNewline
    Write-Host ":" -NoNewline
    Write-Host "$path" -ForegroundColor Blue -NoNewline
    Write-Host "$ " -ForegroundColor Green -NoNewline
    return " "
}

# ===== HISTORY =====
# Reducido para ThinkPad
$MaximumHistoryCount = 5000

# ===== ALIASES =====
Set-Alias -Name .. -Value Set-LocationParent
function Set-LocationParent { Set-Location .. }

Set-Alias -Name ... -Value Set-LocationGrandParent
function Set-LocationGrandParent { Set-Location ../.. }

# ===== FUNCIONES ÚTILES =====
function mkcd {
    param([string]$path)
    New-Item -ItemType Directory -Force -Path $path | Out-Null
    Set-Location $path
}

# ===== EDITOR =====
$env:EDITOR = "nvim"
$env:VISUAL = "nvim"

# ===== PERFORMANCE =====
# Deshabilitar telemetría (performance)
$env:POWERSHELL_TELEMETRY_OPTOUT = 1

# ===== PSReadLine OPTIMIZADO =====
if (Get-Module PSReadLine) {
    # Historial compacto
    Set-PSReadLineOption -MaximumHistoryCount 5000
    
    # Prediction inline (útil)
    Set-PSReadLineOption -PredictionSource History
    
    # Colores
    Set-PSReadLineOption -Colors @{
        Command = 'Green'
        Parameter = 'Cyan'
        String = 'Yellow'
    }
}
