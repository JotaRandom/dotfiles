# Xed Editor Preferences - Optimizado para ThinkPad L420 (1366x768)
# gsettings para Xed (fork de gedit para Linux Mint)

# Similar a gedit pero con namespace diferente
# Aplicar con: gsettings set org.x.editor.preferences.editor ...

cat > /tmp/apply-xed-settings.sh << 'EOF'
#!/bin/bash
# Xed config optimizado para 1366x768

# Fuente pequeña
gsettings set org.x.editor.preferences.editor editor-font 'Monospace 9'
gsettings set org.x.editor.preferences.editor use-default-font false

# Números de línea
gsettings set org.x.editor.preferences.editor display-line-numbers true

# Resaltar línea actual
gsettings set org.x.editor.preferences.editor highlight-current-line true

# Resaltar paréntesis
gsettings set org.x.editor.preferences.editor bracket-matching true

# Tabs a espacios
gsettings set org.x.editor.preferences.editor tabs-size 4
gsettings set org.x.editor.preferences.editor insert-spaces true

# Auto-indent
gsettings set org.x.editor.preferences.editor auto-indent true

# Wrap
gsettings set org.x.editor.preferences.editor wrap-mode 'word'

# Tema oscuro
gsettings set org.x.editor.preferences.editor scheme 'oblivion'

# Sin minimap (ganar espacio horizontal)
gsettings set org.x.editor.preferences.editor display-overview-map false

# Sin right margin (más espacio)
gsettings set org.x.editor.preferences.editor display-right-margin false

echo "Xed configurado para ThinkPad L420 (1366x768)"
EOF

chmod +x /tmp/apply-xed-settings.sh
