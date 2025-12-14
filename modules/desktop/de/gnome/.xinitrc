#!/bin/sh
# .xinitrc para GNOME - Optimizado para ThinkPad L420 (1366x768)

# ------------------------------------------------------------------
# 1. Cargar configuraciones del sistema
# ------------------------------------------------------------------
[ -f /etc/X11/xinit/xinitrc ] && . /etc/X11/xinit/xinitrc
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources
[ -f ~/.Xmodmap ] && xmodmap ~/.Xmodmap

# ------------------------------------------------------------------
# 2. Configuraciones básicas de X
# ------------------------------------------------------------------
xset -b
xsetroot -solid "#2d2d2d"
xset r rate 300 50

# ------------------------------------------------------------------
# 3. Locale y teclado
# ------------------------------------------------------------------
export LANG=es_CL.UTF-8
export LC_ALL=es_CL.UTF-8
export LANGUAGE=es_CL.UTF-8
setxkbmap latam

# ===== OPTIMIZACIONES PANTALLA PEQUEÑA (1366x768) =====
(sleep 3 &&
  # Deshabilitar animaciones (GPU limitada)
  gsettings set org.gnome.desktop.interface enable-animations false
  
  # Fuentes pequeñas (9pt)
  gsettings set org.gnome.desktop.interface font-name 'Sans 9'
  gsettings set org.gnome.desktop.interface document-font-name 'Sans 9'
  gsettings set org.gnome.desktop.interface monospace-font-name 'Monospace 9'
  gsettings set org.gnome.desktop.wm.preferences titlebar-font 'Sans Bold 9'
  
  # Scaling 1
  gsettings set org.gnome.desktop.interface scaling-factor uint32 1
  
  # Top bar compacto
  gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed false
  
  # Deshabilitar blur/transparencias (performance)
  gsettings set org.gnome.desktop.interface gtk-enable-primary-paste false
) &

exec gnome-session
