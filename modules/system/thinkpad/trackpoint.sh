#!/bin/bash
# TrackPoint configuration for ThinkPad L420
# ~/.config/thinkpad/trackpoint.sh
# 
# Run this script at startup via .xinitrc or systemd user service
# For systemd user service: systemctl --user enable trackpoint-config.service

# Esperar a que X esté listo
sleep 2

# Nombre del dispositivo TrackPoint (puede variar)
TRACKPOINT_NAME="TPPS/2 IBM TrackPoint"

# Verificar si xinput está disponible
if ! command -v xinput &> /dev/null; then
    echo "xinput no encontrado, instalando xorg-xinput..."
    exit 1
fi

# Verificar si el dispositivo existe
if ! xinput list | grep -q "$TRACKPOINT_NAME"; then
    echo "TrackPoint no encontrado. Listando dispositivos:"
    xinput list
    exit 1
fi

# ===== CONFIGURACIÓN DE SENSIBILIDAD =====

# Aceleración constante (menor = más sensible)
# Valores: 0.1 (muy sensible) a 2.0 (poco sensible)
# Recomendado para L420: 0.4-0.5
xinput set-prop "$TRACKPOINT_NAME" "Device Accel Constant Deceleration" 0.45

# Velocidad de aceleración
# Valores: -1.0 (lento) a 1.0 (rápido)
# Recomendado: 0.6
xinput set-prop "$TRACKPOINT_NAME" "Device Accel Velocity Scaling" 0.6

# ===== TRACKPOINT KERNEL SETTINGS =====
# Estas son alternativas que se pueden configurar en /etc/udev/rules.d/

# Sensibilidad (sensitivity): 1-255 (default 128)
# Mayor = más sensible
if [ -w /sys/devices/platform/i8042/serio1/serio2/sensitivity ]; then
    echo 200 | sudo tee /sys/devices/platform/i8042/serio1/serio2/sensitivity
fi

# Velocidad (speed): 1-255 (default 97)
# Mayor = más rápido
if [ -w /sys/devices/platform/i8042/serio1/serio2/speed ]; then
    echo 120 | sudo tee /sys/devices/platform/i8042/serio1/serio2/speed
fi

# Inercia (inertia): 0-255 (default 6)
# Menor = menos inercia
if [ -w /sys/devices/platform/i8042/serio1/serio2/inertia ]; then
    echo 4 | sudo tee /sys/devices/platform/i8042/serio1/serio2/inertia
fi

# ===== BOTONES DEL MEDIO =====
# Configurar scroll con botón del medio + TrackPoint
# Esto requiere que libinput esté configurado correctamente

# Habilitar scroll con botón del medio
xinput set-prop "$TRACKPOINT_NAME" "libinput Scroll Method Enabled" 0, 0, 1

# ===== LOGGING =====
echo "TrackPoint configurado:"
xinput list-props "$TRACKPOINT_NAME" | grep -E "Accel|Scroll"

# ===== NOTAS =====
# Para hacer permanentes los cambios de kernel (sensitivity, speed, inertia):
# Crear archivo /etc/udev/rules.d/10-trackpoint.rules:
#
# ACTION=="add", SUBSYSTEM=="input", ATTR{name}=="TPPS/2 IBM TrackPoint", \
# ATTR{device/sensitivity}="200", \
# ATTR{device/speed}="120", \
# ATTR{device/inertia}="4"
