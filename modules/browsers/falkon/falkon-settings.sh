# Falkon Browser Preferences - Windows 95/98 Retro Style
# Aplicar con: bash modules/browsers/falkon/falkon-settings.sh

# Falkon es Qt, así que heredará el tema Qt (Chicago95/Classic 98)
# Aquí podemos forzar ciertos comportamientos en su archivo settings.ini

FALKON_CONFIG="$HOME/.config/falkon/settings.ini"

if [ -f "$FALKON_CONFIG" ]; then
    # Forzar uso de iconos del sistema (retro)
    sed -i 's/UseSystemIcons=false/UseSystemIcons=true/g' "$FALKON_CONFIG"
    # Forzar barra de herramientas tradicional
    sed -i 's/TitlebarCustomAppearance=true/TitlebarCustomAppearance=false/g' "$FALKON_CONFIG"
    echo "✓ Falkon configurado para heredar el estilo del sistema."
else
    echo "⚠ No se encontró la configuración de Falkon en $FALKON_CONFIG"
    echo "Inicia Falkon una vez para generar los archivos base."
fi
