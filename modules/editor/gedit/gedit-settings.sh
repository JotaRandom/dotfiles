# Gedit Preferences - Optimizado para ThinkPad L420 (1366x768)
# gsettings (aplicar con: gsettings set org.gnome.gedit.preferences.editor ...)

# Fuente pequeña para pantalla pequeña
# gsettings set org.gnome.gedit.preferences.editor editor-font 'Monospace 9'
# gsettings set org.gnome.gedit.preferences.editor use-default-font false

# Números de línea
# gsettings set org.gnome.gedit.preferences.editor display-line-numbers true

# Resaltar línea actual
# gsettings set org.gnome.gedit.preferences.editor highlight-current-line true

# Resaltar paréntesis
# gsettings set org.gnome.gedit.preferences.editor bracket-matching true

# Tabs
# gsettings set org.gnome.gedit.preferences.editor tabs-size 4
# gsettings set org.gnome.gedit.preferences.editor insert-spaces true

# Auto-indent
# gsettings set org.gnome.gedit.preferences.editor auto-indent true

# Wrap
# gsettings set org.gnome.gedit.preferences.editor wrap-mode 'word'

# Tema oscuro
# gsettings set org.gnome.gedit.preferences.editor scheme 'oblivion'

# Sin minimap (ganar espacio)
# gsettings set org.gnome.gedit.preferences.editor display-overview-map false

# Aplicar todo de una vez:
# Para aplicar estas configuraciones, ejecuta:
# bash apply-gedit-settings.sh

cat > /tmp/apply-gedit-settings.sh << 'EOF'
#!/bin/bash
gsettings set org.gnome.gedit.preferences.editor editor-font 'Monospace 9'
gsettings set org.gnome.gedit.preferences.editor use-default-font false
gsettings set org.gnome.gedit.preferences.editor display-line-numbers true
gsettings set org.gnome.gedit.preferences.editor highlight-current-line true
gsettings set org.gnome.gedit.preferences.editor bracket-matching true
gsettings set org.gnome.gedit.preferences.editor tabs-size 4
gsettings set org.gnome.gedit.preferences.editor insert-spaces true
gsettings set org.gnome.gedit.preferences.editor auto-indent true
gsettings set org.gnome.gedit.preferences.editor wrap-mode 'word'
gsettings set org.gnome.gedit.preferences.editor scheme 'oblivion'
gsettings set org.gnome.gedit.preferences.editor display-overview-map false
echo "Gedit configurado para 1366x768"
EOF
chmod +x /tmp/apply-gedit-settings.sh
