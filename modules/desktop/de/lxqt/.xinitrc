#!/bin/sh
# ~/.xinitrc - Inicio para LXQt vía startx
# Optimizado específicamente para LXQt Desktop Environment

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
# 3. Configuración de locale y teclado
# ------------------------------------------------------------------
export LANG=es_CL.UTF-8
export LC_ALL=es_CL.UTF-8
export LANGUAGE=es_CL.UTF-8
setxkbmap latam

# ------------------------------------------------------------------
# 4. Servicios específicos para LXQt
# ------------------------------------------------------------------
# Polkit para LXQt
if command -v lxqt-policykit-agent >/dev/null 2>&1; then
    lxqt-policykit-agent &
fi

# NetworkManager applet
if command -v nm-applet >/dev/null 2>&1; then
    nm-applet &
fi

# ------------------------------------------------------------------
# 5. Iniciar LXQt
# ------------------------------------------------------------------
exec startlxqt
