#!/usr/bin/env bash
# Instalador básico de dotfiles para sistemas Unix (usa GNU Stow)

set -euo pipefail

usage(){
  cat <<EOF
Usage: $0 [module1 module2 ...]
If no modules specified, defaults to: shell/tmux shell/bash shell/zsh windowing/x11 desktop/xfce modules/system/etc
EOF
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  usage
  exit 0
fi

MODULES=("modules/shell/bash" "modules/shell/zsh" "modules/tmux" "modules/windowing/x11" "modules/desktop/xfce" "modules/system/etc")
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
