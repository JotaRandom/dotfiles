# Xreader Preferences - Windows 95/98 Retro Style
# Aplicar con: bash modules/editor/xreader/xreader-settings.sh

# Sidebar e interfaz compacta (estilo Acrobat Reader 3.0)
gsettings set org.x.reader.default sidebar-visible false
gsettings set org.x.reader.default toolbar-visible true
gsettings set org.x.reader.default statusbar-visible true

# Zoom y Vista
gsettings set org.x.reader.default zoom-mode 'fit-width'
gsettings set org.x.reader.default continuous true
gsettings set org.x.reader.default dual-page false

# Colores (aunque mayormente depende del documento)
# Forzar colores del sistema si es posible (algunos visores lo permiten)
# En Xreader suele ser a través de las preferencias de accesibilidad si se desea invertir
# gsettings set org.x.reader.default use-high-contrast false

echo "✓ Xreader configurado con estilo Windows 95/98."
