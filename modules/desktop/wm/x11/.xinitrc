#!/bin/sh
# ~/.xinitrc - Inicio GENÉRICO para window managers standalone
# Usar para: i3, awesome, bspwm, dwm, openbox, fluxbox, etc.
# Este archivo debe editarse para especificar qué WM iniciar

# ------------------------------------------------------------------
# 1. Cargar configuraciones del sistema
# ------------------------------------------------------------------
[ -f /etc/X11/xinit/xinitrc ] && . /etc/X11/xinit/xinitrc
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources
[ -f ~/.Xmodmap ] && xmodmap ~/.Xmodmap

# ------------------------------------------------------------------
# 2. Configuraciones básicas de X
# ------------------------------------------------------------------
# Desactivar pitido
xset -b

# Fondo sólido (evita fondo negro)
xsetroot -solid "#2d2d2d"

# Repetición de teclado
xset r rate 300 50

# ------------------------------------------------------------------
# 3. Configuración de locale y teclado  
# ------------------------------------------------------------------
export LANG=es_CL.UTF-8
export LC_ALL=es_CL.UTF-8
export LANGUAGE=es_CL.UTF-8

# Teclado latinoamericano
setxkbmap latam

# ------------------------------------------------------------------
# 4. Servicios básicos para window managers
# ------------------------------------------------------------------
# Polkit (autenticación gráfica)
if [ -x /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 ]; then
    /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
fi

# NetworkManager applet (gestión de redes)
if command -v nm-applet >/dev/null 2>&1; then
    nm-applet &
fi

# Compositor (opcional - descomentar si se usa)
# if command -v picom >/dev/null 2>&1; then
#     picom -b &
# fi

# Wallpaper (opcional - descomentar y ajustar)
# if command -v feh >/dev/null 2>&1; then
#     feh --bg-scale ~/Pictures/wallpaper.jpg &
# fi

# ------------------------------------------------------------------
# 5. Iniciar Window Manager
# ------------------------------------------------------------------
# Descomentar/editar el WM que deseas usar:

# i3 window manager
exec i3

# Awesome window manager
# exec awesome

# bspwm
# exec bspwm

# dwm
# exec dwm

# Openbox
# exec openbox-session

# Fluxbox
# exec startfluxbox
