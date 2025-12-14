#!/bin/sh
# ~/.xinitrc - Inicio para KDE Plasma vía startx
# Optimizado para KDE Plasma (minimalista - KDE maneja servicios internamente)

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
# 4. KDE Plasma maneja todos los servicios internamente
# ------------------------------------------------------------------
# startkde/startplasma-x11 inicia todos los servicios necesarios

# ------------------------------------------------------------------
# 5. Iniciar KDE Plasma
# ------------------------------------------------------------------
export DESKTOP_SESSION=plasma
exec startplasma-x11
