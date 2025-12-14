#!/bin/sh
# ~/.xinitrc - Inicio para GNOME vía startx
# Optimizado para GNOME (minimalista - GNOME maneja servicios internamente)

# ------------------------------------------------------------------
# 1. Cargar configuraciones del sistema
# ------------------------------------------------------------------
[ -f /etc/X11/xinit/xinitrc ] && . /etc/X11/xinit/xinitrc
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources

# ------------------------------------------------------------------
# 2. Configuraciones básicas de X
# ------------------------------------------------------------------
xset -b
xset r rate 300 50

# ------------------------------------------------------------------
# 3. Configuración de locale y teclado
# ------------------------------------------------------------------
export LANG=es_CL.UTF-8
export LC_ALL=es_CL.UTF-8
export LANGUAGE=es_CL.UTF-8
setxkbmap latam

# ------------------------------------------------------------------
# 4. GNOME maneja todos los servicios internamente
# ------------------------------------------------------------------
# No es necesario lanzar polkit, nm-applet, power-manager, etc.
# gnome-session los inicia automáticamente

# ------------------------------------------------------------------
# 5. Iniciar GNOME
# ------------------------------------------------------------------
export XDG_SESSION_TYPE=x11
exec gnome-session
