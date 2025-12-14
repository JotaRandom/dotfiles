#!/bin/sh
# .xinitrc para WM minimalistas (TWM, IceWM, FVWM, etc.)
# Optimizado para ThinkPad L420 (1366x768)

# ------------------------------------------------------------------
# 1. Cargar recursos y configuraciones del sistema
# ------------------------------------------------------------------
[ -f /etc/X11/xinit/xinitrc ] && . /etc/X11/xinit/xinitrc
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources
[ -f ~/.Xmodmap ] && xmodmap ~/.Xmodmap

# ------------------------------------------------------------------
# 2. Configuraciones básicas de X
# ------------------------------------------------------------------
# Desactivar beep
xset -b

# Fondo de pantalla sólido (liviano)
xsetroot -solid "#2d2d2d"

# Tasa de repetición del teclado
xset r rate 300 50

# ------------------------------------------------------------------
# 3. Locale y teclado
# ------------------------------------------------------------------
export LANG=es_CL.UTF-8
export LC_ALL=es_CL.UTF-8
export LANGUAGE=es_CL.UTF-8
setxkbmap latam

# ------------------------------------------------------------------
# 4. Servicios mínimos (solo lo esencial para WM básico)
# ------------------------------------------------------------------
# Polkit (autenticación gráfica básica)
if [ -x /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 ]; then
    /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
fi

# NetworkManager applet (si está disponible)
if command -v nm-applet >/dev/null 2>&1; then
    nm-applet &
fi

# ------------------------------------------------------------------
# 5. Panel ligero (opcional - lxpanel o tint2)
# ------------------------------------------------------------------
# Descomentar si quieres panel en WM minimalista
# if command -v tint2 >/dev/null 2>&1; then
#     tint2 &
# elif command -v lxpanel >/dev/null 2>&1; then
#     lxpanel --profile default &
# fi

# ------------------------------------------------------------------
# 6. Optimizaciones específicas para 1366x768
# ------------------------------------------------------------------
# Sin compositor (WM minimalistas no lo necesitan)
# Fuentes configuradas en ~/.config/fontconfig/fonts.conf

# ------------------------------------------------------------------
# 7. Iniciar Window Manager
# ------------------------------------------------------------------
# Descomentar el WM que uses:

# TWM (muy básico, ideal para L420)
exec twm

# IceWM (ligero y funcional)
# exec icewm-session

# FVWM (altamente configurable)
# exec fvwm

# i3 (tiling WM)
# exec i3

# Openbox (ligero y moderno)
# exec openbox-session

# Fluxbox (ligero, estilo blackbox)
# exec startfluxbox
