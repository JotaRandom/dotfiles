#!/bin/bash
# WindowMaker .xinitrc - NeXTSTEP Style
# ThinkPad L420 (1366x768)

# Background NeXTSTEP style (gris oscuro)
xsetroot -solid "#2F4F4F" &

# Compositor OFF (WindowMaker maneja todo)
# WM ya tiene compositing básico

# DPI
xrandr --dpi 96

# Iniciar WindowMaker
exec wmaker
