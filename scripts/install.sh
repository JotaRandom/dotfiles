#!/usr/bin/env bash
# Minimal installer for user dotfiles (uses GNU Stow)

set -euo pipefail

usage(){
  cat <<EOF
Usage: $0 [module1 module2 ...]
If no modules specified, defaults to a curated set of user dotfile modules that are safe to
install without modifying system-level configuration.

This script only installs dotfiles under the current user's home directory using GNU Stow.
System-level configuration (e.g., files under /etc like Xorg or udev/hwdb) is NOT modified by this script.
EOF
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  usage
  exit 0
fi

# Default modules: only user-level dotfiles (home directory)
MODULES=(
  "modules/shell/bash"
  "modules/shell/zsh"
  "modules/shell/fish"
  "modules/shell/ksh"
  "modules/shell/tcsh"
  "modules/shell/mksh"
  "modules/shell/elvish"
  "modules/shell/xonsh"
  "modules/shell/pwsh"
  "modules/apps/tmux"
  "modules/apps/xmms"
  "modules/windowing/x11"
  "modules/desktop/chrome"
  "modules/git"
  "modules/editor/nvim"
  "modules/editor/vscode"
  "modules/editor/emacs"
  "modules/editor/vim"
  "modules/editor/nano"
  "modules/editor/latex"
)

if [[ $# -gt 0 ]]; then
  MODULES=("$@")
fi

echo "Instalando dependencias necesarias (stow, git-lfs) si lo permiten el sistema (apt/pacman/dnf)..."
if command -v apt >/dev/null 2>&1; then
  sudo apt update && sudo apt install -y stow git-lfs || true
elif command -v pacman >/dev/null 2>&1; then
  sudo pacman -Syu --noconfirm stow git-lfs || true
elif command -v dnf >/dev/null 2>&1; then
  sudo dnf install -y stow git-lfs || true
else
  echo "No se detectó gestor de paquetes compatible. Asegúrate de instalar 'stow' y 'git-lfs' manualmente."
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

echo "Instalación finalizada. Este instalador solo aplica dotfiles de usuario en \\${HOME}."
echo "Si necesitas aplicar cambios a nivel sistema (Xorg, hwdb, etc.), hazlo manualmente con permisos de root."
echo "Recuerda revisar los archivos instalados para asegurarte de que todo esté como deseas."
