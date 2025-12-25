# Epiphany (GNOME Web) Preferences - Windows 95/98 Retro Style
# Aplicar con: bash modules/browsers/epiphany/epiphany-settings.sh

# Desactivar modo oscuro (usar tema claro del sistema)
gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'

# UI Compacta
gsettings set org.gnome.Epiphany ui-layout 'compact'
gsettings set org.gnome.Epiphany.web enable-popups true

# Página de inicio clásica (blanco o gris)
gsettings set org.gnome.Epiphany homepage-url 'about:blank'

# Fuente (aliased a MS Sans Serif si está disponible)
gsettings set org.gnome.Epiphany.web default-font-family 'DejaVu Sans'
gsettings set org.gnome.Epiphany.web sans-serif-font 'DejaVu Sans'
gsettings set org.gnome.Epiphany.web serif-font 'DejaVu Serif'

echo "✓ Epiphany configurado con enfoque retro."
