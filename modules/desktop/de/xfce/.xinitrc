#!/bin/sh
# ~/.xinitrc - Inicio para XFCE vía startx
# Optimizado específicamente para XFCE Desktop Environment

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
# 4. Servicios específicos para XFCE
# ------------------------------------------------------------------
# Polkit para XFCE
if [ -x /usr/lib/xfce-polkit/xfce-polkit ]; then
    /usr/lib/xfce-polkit/xfce-polkit &
elif [ -x /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 ]; then
    /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
fi

# XFCE Power Manager
if command -v xfce4-power-manager >/dev/null 2>&1; then
    xfce4-power-manager &
fi

# NetworkManager applet
if command -v nm-applet >/dev/null 2>&1; then
    nm-applet &
fi

# ------------------------------------------------------------------
# 5. Iniciar XFCE
# ------------------------------------------------------------------
#!/bin/sh
# .xinitrc para XFCE - Optimizado para ThinkPad L420 (1366x768)

# ===== OPTIMIZACIONES PANTALLA PEQUEÑA Y PERFORMANCE =====
(sleep 3 &&
  # Deshabilitar compositing (GPU limitada)
  xfconf-query -c xfwm4 -p /general/use_compositing -s false
  
  # Theme sin sombras
  xfconf-query -c xfwm4 -p /general/theme -s "Default"
  
  # Panel compacto 24px
  xfconf-query -c xfce4-panel -p /panels/panel-1/size -s 24
  
  # Fuentes pequeñas
  xfconf-query -c xsettings -p /Gtk/FontName -s "Sans 9"
  xfconf-query -c xfwm4 -p /general/title_font -s "Sans Bold 9"
) &

exec startxfce4
