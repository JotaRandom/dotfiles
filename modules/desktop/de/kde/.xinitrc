#!/bin/sh
# .xinitrc para KDE Plasma - Optimizado para ThinkPad L420 (1366x768)

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
# Variables de entorno antes de iniciar Plasma
export PLASMA_USE_QT_SCALING=0
export QT_SCALE_FACTOR=1

(sleep 5 &&
  # Deshabilitar compositor KWin (GPU limitada Intel HD)
  qdbus org.kde.KWin /Compositor suspend
  
  # Panel más compacto (32 -> 24px via kwriteconfig5)
  kwriteconfig5 --file plasmarc --group Theme --key name 'breeze-light'
  
  # Fuentes pequeñas
  kwriteconfig5 --file kdeglobals --group General --key font 'Sans,9,-1,5,50,0,0,0,0,0'
  kwriteconfig5 --file kdeglobals --group General --key fixed 'Monospace,9,-1,5,50,0,0,0,0,0'
  kwriteconfig5 --file kdeglobals --group General --key smallestReadableFont 'Sans,8,-1,5,50,0,0,0,0,0'
  kwriteconfig5 --file kdeglobals --group WM --key activeFont 'Sans,9,-1,5,50,0,0,0,0,0'
  
  # Deshabilitar animaciones
  kwriteconfig5 --file kdeglobals --group KDE --key AnimationDurationFactor 0
  
  # Blur OFF (performance)
  kwriteconfig5 --file kwinrc --group Plugins --key blurEnabled false
  kwriteconfig5 --file kwinrc --group Plugins --key contrastEnabled false
  
  # Recargar KWin
  qdbus org.kde.KWin /KWin reconfigure
) &

exec startkde
