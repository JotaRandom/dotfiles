#!/usr/bin/env bash
# Minimal installer for user dotfiles (uses GNU Stow)

set -euo pipefail
FORCE=0
BACKUP=1
DRY_RUN=0

while [[ ${1:-} =~ ^- ]]; do
  case "$1" in
    -f|--force)
      FORCE=1; shift ;;
    -n|--dry-run)
      DRY_RUN=1; shift ;;
    --no-backup)
      BACKUP=0; shift ;;
    -h|--help)
      usage; exit 0 ;;
    *) break ;;
  esac
done

usage(){
  cat <<EOF
Usage: $0 [module1 module2 ...]
If no modules specified, defaults to a curated set of user dotfile modules that are safe to
install without modifying system-level configuration.

This script only installs dotfiles under the current user's home directory using GNU Stow.
System-level configuration (e.g., files under /etc like Xorg) is NOT modified by this script.
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
    BASENAME=$(basename "$MOD")
    echo "Preparing to stow: $BASENAME -> $TARGET"

    # dry-run check: list conflicting targets
    CONFLICTS=()
    while IFS= read -r -d $'\0' SRC; do
      REL=${SRC#./}
      TARGET_PATH="$TARGET/$REL"
      if [ -e "$TARGET_PATH" ] || [ -L "$TARGET_PATH" ]; then
        # if symlink and pointing to same source, ignore
        if [ -L "$TARGET_PATH" ]; then
          if [ "$(readlink -f "$TARGET_PATH")" = "$(readlink -f "$MOD/$REL")" ]; then
            continue
          fi
        fi
        CONFLICTS+=("$TARGET_PATH")
      fi
    done < <(cd "$(dirname "$MOD")" && find "$(basename "$MOD")" -mindepth 1 -print0)

    if [ ${#CONFLICTS[@]} -gt 0 ]; then
      echo "Conflictos detectados al aplicar module $BASENAME:" >&2
      for c in "${CONFLICTS[@]}"; do echo "  - $c" >&2; done

      if [ $DRY_RUN -eq 1 ]; then
        echo "(dry-run) Skipping backup/overwrite for $BASENAME"
        continue
      fi

      if [ $FORCE -eq 1 ]; then
        echo "Forzando sobrescritura de los archivos conflictivos para $BASENAME"
        for c in "${CONFLICTS[@]}"; do
          rm -rf "$c" || true
        done
      elif [ $BACKUP -eq 1 ]; then
        BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%s)/$BASENAME"
        echo "Respaldando archivos conflictivos a: $BACKUP_DIR"
        for c in "${CONFLICTS[@]}"; do
          mkdir -p "$(dirname "$BACKUP_DIR/$c")" || true
          mv "$c" "$BACKUP_DIR/$c" || true
        done
      else
        echo "Omitiendo $BASENAME (archivos en conflicto presentes)." >&2
        continue
      fi
    fi

    echo "stow -v -t $TARGET $BASENAME"
    if [ $DRY_RUN -eq 1 ]; then
      echo "(dry-run) not actually applying $BASENAME"
    else
      (cd "$(dirname "$MOD")"; stow -v -t "$TARGET" "$BASENAME")
    fi
  else
    echo "Advertencia: módulo $MOD no existe"
  fi
done

echo "Instalación finalizada. Este instalador solo aplica dotfiles de usuario en \\${HOME}."
echo "Si necesitas aplicar cambios a nivel sistema (Xorg, etc.), hazlo manualmente con permisos de root."
echo "Recuerda revisar los archivos instalados para asegurarte de que todo esté como deseas."
 
# Auto-configure git hooks (if available) — this is safe and idempotent and only affects local git config
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  REPO_ROOT=$(git rev-parse --show-toplevel)
  SETUP_SCRIPT="$REPO_ROOT/scripts/setup-githooks.sh"
  if [ -f "$SETUP_SCRIPT" ]; then
    echo "Configurando hooks de git localmente (core.hooksPath -> .githooks)"
    # run setup script, ignore errors (non-fatal)
    "$SETUP_SCRIPT" || true
  fi
fi
