#!/bin/bash
# Openbox .xinitrc - Windows 95 style
# ThinkPad L420 (1366x768)

# Background Win95 teal
feh --bg-scale --no-fehbg -solid "#008080" &

# Compositor OFF (performance)
# Openbox no necesita

# Panel Win95 style (tint2 configurado como Win95 taskbar)
tint2 -c ~/.config/tint2/tint2rc-win95 &

# DPI
xrandr --dpi 96

# Iniciar Openbox
exec openbox-session
