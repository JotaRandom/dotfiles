#!/bin/sh
# .xinitrc para LXQt - Optimizado para ThinkPad L420 (1366x768)

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
# LXQt es ligero por defecto, pero se puede optimizar más

# Variables Qt
export QT_SCALE_FACTOR=1
export QT_AUTO_SCREEN_SCALE_FACTOR=0

(sleep 3 &&
  # Compositor Compton/Picom OFF (performance)
  killall picom 2>/dev/null
  killall compton 2>/dev/null
  
  # Panel compacto 24px (via config)
  # LXQt panel height se configura en ~/.config/lxqt/panel.conf
  if [ -f ~/.config/lxqt/panel.conf ]; then
    sed -i 's/^panelSize=.*/panelSize=24/' ~/.config/lxqt/panel.conf
  fi
  
  # Fuentes pequeñas en Qt
  if [ -f ~/.config/fontconfig/fonts.conf ]; then
    # Ya está configurado en modules/system/fontconfig
    :
  fi
) &

exec startlxqt
