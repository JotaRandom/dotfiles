#!/bin/sh
# ~/.xinitrc - Script de inicio para Cinnamon vía startx
# Útil como respaldo si LightDM falla

# ------------------------------------------------------------------
# 1. Cargar configuraciones del sistema (Xresources, Xmodmap, etc.)
# ------------------------------------------------------------------
[ -f /etc/X11/xinit/xinitrc ] && . /etc/X11/xinit/xinitrc
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources
[ -f ~/.Xmodmap ] && xmodmap ~/.Xmodmap

# ------------------------------------------------------------------
# 2. Configuraciones básicas de X (opcional pero recomendado)
# ------------------------------------------------------------------
# Desactivar el pitido molesto
xset -b

# Fondo de pantalla sólido (evita fondo negro parpadeante)
xsetroot -solid "#2d2d2d"

# Ajustar tasa de repetición del teclado (opcional)
xset r rate 300 50

# ------------------------------------------------------------------
# 3. Iniciar servicios de fondo requeridos por Cinnamon
# ------------------------------------------------------------------
# Polkit (autenticación gráfica)
if [ -x /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 ]; then
    /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
elif [ -x /usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 ]; then
    /usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &
fi

# Gestor de redes (NetworkManager applet)
if command -v nm-applet >/dev/null; then
    nm-applet --sm-disable &
fi

# Gestor de energía (opcional)
if command -v xfce4-power-manager >/dev/null; then
    xfce4-power-manager &
elif command -v mate-power-manager >/dev/null; then
    mate-power-manager &
fi

# ------------------------------------------------------------------
# 4. Iniciar Cinnamon
# ------------------------------------------------------------------
# Usa 'exec' para reemplazar el proceso xinit y evitar cierre prematuro
exec cinnamon-session
