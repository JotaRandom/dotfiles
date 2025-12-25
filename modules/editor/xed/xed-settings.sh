# Xed Editor Preferences - Windows 95/98 Retro Style
# Aplicar con: bash modules/editor/xed/xed-settings.sh

# Font: Usar la fuente del sistema (aliased a MS Sans Serif) o Monospace
gsettings set org.x.editor.preferences.editor editor-font 'MS Sans Serif 9'
gsettings set org.x.editor.preferences.editor use-default-font false

# Esquema de colores: Chicago95 (el que acabamos de crear)
gsettings set org.x.editor.preferences.editor scheme 'chicago95'

# UI Elements
gsettings set org.x.editor.preferences.editor display-line-numbers true
gsettings set org.x.editor.preferences.editor highlight-current-line true
gsettings set org.x.editor.preferences.editor bracket-matching true
gsettings set org.x.editor.preferences.editor display-right-margin false
gsettings set org.x.editor.preferences.editor display-overview-map false

# Indentación
gsettings set org.x.editor.preferences.editor tabs-size 4
gsettings set org.x.editor.preferences.editor insert-spaces true
gsettings set org.x.editor.preferences.editor auto-indent true

# Comportamiento
gsettings set org.x.editor.preferences.editor wrap-mode 'word'
gsettings set org.x.editor.preferences.editor restore-cursor-position true

echo "✓ Xed configurado con estilo Windows 95/98."
echo "Nota: Asegúrate de instalar el archivo Chicago95.xml en ~/.local/share/xed/styles/"
