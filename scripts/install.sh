#!/usr/bin/env bash
# Instalador básico de dotfiles para sistemas Unix (usa GNU Stow)

set -euo pipefail

usage(){
  cat <<EOF
Usage: $0 [module1 module2 ...]
If no modules specified, defaults to: shell/tmux shell/bash shell/zsh windowing/x11 desktop/xfce modules/system/etc
  
Options:
  --xorg         Instala configuración Xorg (InputClass) para aplicar el layout Latin American.
  --hwdb         Instala la plantilla hwdb (udev) para remapeos del kernel. Requiere systemd-hwdb y permisos root.
EOF
}

INSTALL_XORG=0
INSTALL_HWDB=0
if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  usage
  exit 0
fi

if [[ "${1:-}" == "--xorg" ]]; then
  INSTALL_XORG=1
  shift
fi
if [[ "${1:-}" == "--hwdb" ]]; then
  INSTALL_HWDB=1
  shift
fi

MODULES=("modules/shell/bash" "modules/shell/zsh" "modules/shell/fish" "modules/shell/ksh" "modules/shell/tcsh" "modules/shell/mksh" "modules/tmux" "modules/windowing/x11" "modules/desktop/xfce" "modules/system/etc" "modules/apps/xmms" "modules/editor/nvim" "modules/editor/vscode" "modules/editor/emacs" "modules/editor/vim" "modules/editor/nano" "modules/editor/latex")
if [[ $# -gt 0 ]]; then
  MODULES=("$@")
fi

echo "Instalando dependencias (stow, git-lfs) si es que faltan..."
if command -v apt >/dev/null 2>&1; then
  sudo apt update && sudo apt install -y stow git-lfs
elif command -v pacman >/dev/null 2>&1; then
  sudo pacman -Syu --noconfirm stow git-lfs
elif command -v dnf >/dev/null 2>&1; then
  sudo dnf install -y stow git-lfs
else
  echo "No se detectó gestor de paquetes conocido. Instala 'stow' y 'git-lfs' manualmente."
fi

git lfs install || true

TARGET="$HOME"
echo "Usando target: $TARGET"
for MOD in "${MODULES[@]}"; do
  if [ -d "$MOD" ]; then
    echo "stow -v -t $TARGET $(basename "$MOD")"
    (cd "$(dirname "$MOD")"; stow -v -t "$TARGET" "$(basename "$MOD")")
  else
    echo "Advertencia: módulo $MOD no existe"
  fi
done

echo "Instalación finalizada. Revisa los enlaces simbólicos y reinicia tu sesión si aplica."

if [[ "$INSTALL_XORG" -eq 1 ]]; then
  echo "Instalando configuración Xorg (InputClass) para asegurar latam keymap..."
  if [[ $(id -u) -ne 0 ]]; then
    SUDO=sudo
  else
    SUDO=""
  fi
  # Copy Xorg InputClass to set `latam` layout (preferred over udev ENV approach)
  $SUDO cp modules/system/etc/X11/90-latin-keyboard.conf /etc/X11/xorg.conf.d/ || true
  echo "Instalación Xorg completada. Reinicia la sesión gráfica para aplicar el ajuste." 
fi

if [[ "$INSTALL_HWDB" -eq 1 ]]; then
  echo "Instalando plantilla hwdb (udev) para remapeos de teclado..."
  if [[ $(id -u) -ne 0 ]]; then
    SUDO=sudo
  else
    SUDO=""
  fi
  $SUDO mkdir -p /etc/udev/hwdb.d || true
  $SUDO cp modules/system/etc/udev/hwdb.d/90-latin-layout.hwdb /etc/udev/hwdb.d/ || true
  echo "Actualizando hwdb y forzando trigger de UDEV..."
  $SUDO systemd-hwdb update || true
  $SUDO udevadm trigger || true
  echo "Instalación hwdb completada. Revisa /etc/udev/hwdb.d/90-latin-layout.hwdb y ajusta mapeos si es necesario."
fi
