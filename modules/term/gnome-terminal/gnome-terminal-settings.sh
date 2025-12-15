#!/bin/bash
# GNOME Terminal config - Estilo Linux Mint para ThinkPad L420
# Aplicar con: bash gnome-terminal-settings.sh
# Path: modules/term/gnome-terminal/

# GNOME Terminal usa dconf/gsettings, no archivo de texto
# Este script aplica la configuración Linux Mint style optimizada para 1366x768

PROFILE_ID=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d "'")

# Si no hay perfil default, usar el primero disponible
if [ -z "$PROFILE_ID" ]; then
    PROFILE_ID=$(gsettings get org.gnome.Terminal.ProfilesList list | grep -oP "'\K[^']+(?=')" | head -n1)
fi

PROFILE_PATH="org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/"

echo "Configurando GNOME Terminal (perfil: $PROFILE_ID) estilo Linux Mint para ThinkPad L420..."

# ===== FUENTE (9pt para 1366x768) =====
gsettings set "$PROFILE_PATH" use-system-font false
gsettings set "$PROFILE_PATH" font 'Monospace 9'

# ===== COLORES - Linux Mint style (verde menta) =====
gsettings set "$PROFILE_PATH" use-theme-colors false
gsettings set "$PROFILE_PATH" foreground-color '#FFFFFF'
gsettings set "$PROFILE_PATH" background-color '#2C2C2C'

# Paleta Linux Mint (verde menta como color de acento)
gsettings set "$PROFILE_PATH" palette "['#2C2C2C', '#CC0000', '#4E9A06', '#C4A000', '#3465A4', '#75507B', '#06989A', '#D3D7CF', '#555753', '#EF2929', '#8AE234', '#FCE94F', '#729FCF', '#AD7FA8', '#34E2E2', '#EEEEEC']"

# Bold color
gsettings set "$PROFILE_PATH" bold-color '#FFFFFF'
gsettings set "$PROFILE_PATH" bold-color-same-as-fg true

# ===== CURSOR =====
gsettings set "$PROFILE_PATH" cursor-shape 'block'
gsettings set "$PROFILE_PATH" cursor-blink-mode 'on'

# ===== SCROLLING (optimizado para RAM) =====
gsettings set "$PROFILE_PATH" scrollback-lines 5000  # Reducido de 10000
gsettings set "$PROFILE_PATH" scrollbar-policy 'never'  # Sin scrollbar (ganar espacio)
gsettings set "$PROFILE_PATH" scroll-on-output false
gsettings set "$PROFILE_PATH" scroll-on-keystroke true

# ===== TAMAÑO Y COMPORTAMIENTO =====
gsettings set "$PROFILE_PATH" default-size-columns 100
gsettings set "$PROFILE_PATH" default-size-rows 30
gsettings set "$PROFILE_PATH" use-transparent-background false
gsettings set "$PROFILE_PATH" audible-bell false
gsettings set "$PROFILE_PATH" visible-bell false

# ===== SHELL =====
gsettings set "$PROFILE_PATH" use-custom-command false  # Usar shell por defecto
gsettings set "$PROFILE_PATH" login-shell true

# ===== WINDOW (sin decoraciones para ganar espacio) =====
gsettings set org.gnome.Terminal.Legacy.Settings default-show-menubar false
gsettings set org.gnome.Terminal.Legacy.Settings theme-variant 'dark'

echo "✓ GNOME Terminal configurado estilo Linux Mint"
echo "  - Fuente: Monospace 9pt"
echo "  - Colores: Verde menta accent (#8AE234)"
echo "  - Scrollback: 5000 líneas"
echo "  - Sin scrollbar, sin menubar"
