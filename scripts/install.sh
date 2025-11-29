#!/usr/bin/env bash
# Minimal installer for user dotfiles (uses GNU Stow)

set -euo pipefail

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

    # Safety: skip modules that contain system-level paths (e.g., etc/) because this installer
    # only operates on user-level files under $HOME. If you intentionally want to apply system
    # files, handle them manually (or run a separate system installer as root).
    if (cd "$(dirname "$MOD")" && find "$(basename "$MOD")" -mindepth 1 -maxdepth 2 -type f -path '*/etc/*' | read); then
      echo "Skipping module $BASENAME because it contains system-level files under 'etc/'." >&2
      echo "This installer will not apply files intended for /etc (e.g., /etc/thinkfan.conf)." >&2
      continue
    fi

    # Helper: map some well-known module-root filenames into XDG / proper destinations
    map_target(){
      local srcfile="$1" module_name="$2"
      case "$(basename "$srcfile")" in
        config.fish)
          echo "$TARGET/.config/fish/config.fish";;
        init.vim)
          # Prefer Neovim user config path
          echo "$TARGET/.config/nvim/init.vim";;
        settings.json)
          # VSCode user settings or micro
          if [[ "$module_name" == "vscode" ]]; then
            echo "$TARGET/.config/Code/User/settings.json"
          elif [[ "$module_name" == "micro" ]]; then
            echo "$TARGET/.config/micro/settings.json"
          else
            # unknown mapping, default to HOME
            echo "$TARGET/$srcfile"
          fi;;
        config.json)
          # micro: config.json -> ~/.config/micro/config.json
          if [[ "$module_name" == "micro" ]]; then
            echo "$TARGET/.config/micro/config.json"
          else
            echo "$TARGET/$srcfile"
          fi;;
        *)
          echo "$TARGET/$srcfile";;
      esac
    }

    # dry-run check: list conflicting targets (consider XDG mappings)
    CONFLICTS=()
    while IFS= read -r -d $'\0' SRC; do
      # compute REL relative to the module root (strip the module folder prefix)
      REL=${SRC#"${BASENAME}"/}
      TARGET_PATH=$(map_target "$REL" "$BASENAME")
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
      BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%s)/$BASENAME"
      echo "Respaldando archivos conflictivos a: $BACKUP_DIR"
      for c in "${CONFLICTS[@]}"; do
        RELPATH="${c#"$HOME"/}"
        mkdir -p "$(dirname "$BACKUP_DIR/$RELPATH")" || true
        mv "$c" "$BACKUP_DIR/$RELPATH" || true
      done
    fi

    # Some modules have files at module root that are actually intended for XDG paths
    # We'll create those specific symlinks first and avoid letting stow place them in $HOME.
    # Create a temporary sanitized module for stow (exclude mapped root files and any etc/ entries)
    TMP_MOD_DIR="$(mktemp -d)"
    TMP_NAME="${BASENAME}.tmp"
    mkdir -p "$TMP_MOD_DIR/$TMP_NAME"
    # Copy module contents but exclude files at root that map to other locations and exclude etc/
    (cd "$(dirname "$MOD")" && rsync -a --exclude 'etc/' \
      --exclude 'config.fish' --exclude 'init.vim' --exclude 'settings.json' \
      "$(basename "$MOD")/" "$TMP_MOD_DIR/$TMP_NAME/")

    # Handle mapped root files (create proper XDG symlinks)
    for f in $(cd "$(dirname "$MOD")" && find "$(basename "$MOD")" -mindepth 1 -maxdepth 1 -type f -printf "%f\n" 2>/dev/null || true); do
      DEST=$(map_target "$f" "$BASENAME")
      # If file maps into a subdir of $HOME (XDG), create parent and symlink it
      if [[ "$DEST" != "$TARGET/$f" ]]; then
        if [ -L "$DEST" ] && [ "$(readlink -f "$DEST")" = "$(readlink -f "$MOD/$f")" ]; then
          echo "Skipping already-present symlink: $DEST"
        else
          if [ -e "$DEST" ] || [ -L "$DEST" ]; then
            BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%s)/$BASENAME"
            mkdir -p "$(dirname "$BACKUP_DIR/$f")" || true
            echo "Backing up existing $DEST to $BACKUP_DIR/$f"
            mv "$DEST" "$BACKUP_DIR/$f" || true
          fi
          mkdir -p "$(dirname "$DEST")" || true
          echo "Creating symlink: $DEST -> $MOD/$f"
          ln -sf "$(readlink -f "$MOD/$f")" "$DEST"
        fi
      fi
    done

    echo "stow -v -t $TARGET $TMP_NAME"
    echo "Aplicando module $BASENAME (via sanitized copy)"
    (cd "$TMP_MOD_DIR"; stow -v -t "$TARGET" "$TMP_NAME") || true
    # cleanup
    rm -rf "$TMP_MOD_DIR"
    
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
