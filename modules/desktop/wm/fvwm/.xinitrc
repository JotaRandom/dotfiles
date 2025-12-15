#!/bin/bash
# FVWM .xinitrc - Windows 95 style
# ThinkPad L420 (1366x768)

# Background Win95 teal
xsetroot -solid "#008080" &

# Compositor OFF
# FVWM no necesita

# DPI
xrandr --dpi 96

# Iniciar FVWM
exec fvwm
