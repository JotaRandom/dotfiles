#!/bin/bash
# IceWM .xinitrc - Windows 95 style
# ThinkPad L420 (1366x768)

# Wallpaper Win95 teal
xsetroot -solid "#008080" &

# Compositor OFF (performance)
# IceWM no necesita compositor

# DPI para 1366x768
xrandr --dpi 96

# Iniciar IceWM
exec icewm-session
