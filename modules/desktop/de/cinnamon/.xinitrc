#!/bin/sh
# ~/.xinitrc - Inicio para Cinnamon vía startx
# Optimizado específicamente para Cinnamon Desktop Environment

# ------------------------------------------------------------------
# 1. Cargar configuraciones del sistema (Xresources, Xmodmap, etc.)
# ------------------------------------------------------------------
[ -f /etc/X11/xinit/xinitrc ] && . /etc/X11/xinit/xinitrc
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources
[ -f ~/.Xmodmap ] && xmodmap ~/.Xmodmap

# ------------------------------------------------------------------
# 2. Configuraciones básicas de X
# ------------------------------------------------------------------
# Desactivar el pitido molesto
xset -b

# Fondo de pantalla sólido (evita fondo negro parpadeante)
xsetroot -solid "#2d2d2d"

# Ajustar tasa de repetición del teclado
xset r rate 300 50

# ------------------------------------------------------------------
# 3. Configuración de locale y teclado
# ------------------------------------------------------------------
export LANG=es_CL.UTF-8
export LC_ALL=es_CL.UTF-8
export LANGUAGE=es_CL.UTF-8

# Cargar teclado latinoamericano
setxkbmap latam

# ------------------------------------------------------------------
# 4. Servicios específicos para Cinnamon
# ------------------------------------------------------------------
# Polkit (autenticación gráfica) - Cinnamon usa polkit-gnome
if [ -x /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 ]; then
    /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
elif [ -x /usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 ]; then
    /usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &
fi

# NetworkManager applet (Cinnamon lo integra pero puede necesitarse aquí)
if command -v nm-applet >/dev/null 2>&1; then
    nm-applet --sm-disable &
fi

# Gestor de energía - Preferir Cinnamon Settings Daemon
if command -v csd-power >/dev/null 2>&1; then
    csd-power &
elif command -v mate-power-manager >/dev/null 2>&1; then
    mate-power-manager &
fi

# ------------------------------------------------------------------
# 5. Iniciar Cinnamon
# ------------------------------------------------------------------
# Usa 'exec' para reemplazar el proceso xinit
exec cinnamon-session
