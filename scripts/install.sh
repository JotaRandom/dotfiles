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

# Load mapping rules if available (install-mappings.yml)
declare -A _MAPPER_GLOBAL _MAPPER_MODULE
DEFAULT_ACTION="dotify"
MAPPINGS_FILE="$(git rev-parse --show-toplevel 2>/dev/null || echo .)/install-mappings.yml"
if [ -f "$MAPPINGS_FILE" ]; then
  while IFS= read -r line || [ -n "$line" ]; do
    # strip comments
    line="${line%%#*}"
    # trim
    line="${line#${line%%[![:space:]]*}}"
    line="${line%${line##*[![:space:]]}}"
    [ -z "$line" ] && continue
    if [[ "$line" =~ ^default_action:[[:space:]]*([a-zA-Z_]+) ]]; then
      DEFAULT_ACTION="${BASH_REMATCH[1]}"
      continue
    fi
    if [[ "$line" =~ ^([^:]+):[[:space:]]*(.+)$ ]]; then
      key="${BASH_REMATCH[1]}"; val="${BASH_REMATCH[2]}"
      # trim spaces
      key="${key#${key%%[![:space:]]*}}"; key="${key%${key##*[![:space:]]}}"
      val="${val#${val%%[![:space:]]*}}"; val="${val%${val##*[![:space:]]}}"
      # module-specific mapping: name|module
      if [[ "$key" == *"|"* ]]; then
        name="${key%%|*}"; mod="${key##*|}"
        _MAPPER_MODULE["$name|$mod"]="$val"
      else
        _MAPPER_GLOBAL["$key"]="$val"
      fi
    fi
  done < "$MAPPINGS_FILE"
fi
# Build a quick set of mapped root filenames from the mapping file
declare -A _MAPPED_NAMES
for k in "${!_MAPPER_GLOBAL[@]}"; do _MAPPED_NAMES["$k"]=1; done
for k in "${!_MAPPER_MODULE[@]}"; do name="${k%%|*}"; _MAPPED_NAMES["$name"]=1; done
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

    # Helper: map target path using only install-mappings.yml values and DEFAULT_ACTION
    map_target(){
      local srcfile="$1" module_name="$2"
      # Use XDG dirs when available, fall back to standard locations
      XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
      XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
      XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
      XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
      # prefer declarative mapping from install-mappings.yml if present
      local base="$(basename "$srcfile")"
      if [[ -n "${_MAPPER_MODULE["$base|$module_name"]+x}" ]]; then
        mapping="${_MAPPER_MODULE["$base|$module_name"]}"
      elif [[ -n "${_MAPPER_GLOBAL["$base"]+x}" ]]; then
        mapping="${_MAPPER_GLOBAL["$base"]}"
      else
        mapping=""
      fi
      if [ -n "$mapping" ]; then
        # allow special sentinel values in mapping like 'ignore' or 'skip' to indicate
        # "do not create a mapping / link for this root file"
        if [[ "$mapping" =~ ^(ignore|skip)$ ]]; then
          echo "__IGNORE__"
          return
        fi
        case "$mapping" in
          xdg:*) echo "${XDG_CONFIG_HOME}/${mapping#xdg:}"; return;;
          xdg_state:*) echo "${XDG_STATE_HOME}/${mapping#xdg_state:}"; return;;
          xdg_data:*) echo "${XDG_DATA_HOME}/${mapping#xdg_data:}"; return;;
          xdg_cache:*) echo "${XDG_CACHE_HOME}/${mapping#xdg_cache:}"; return;;
          home:*) echo "$TARGET/${mapping#home:}"; return;;
          *) echo "$TARGET/$srcfile"; return;;
        esac
      fi

      # No mapping present — obey DEFAULT_ACTION
      case "$DEFAULT_ACTION" in
        dotify)
          # dotify: create a dot-prefixed name in HOME unless it already starts with '.'
          if [[ "$base" == .* ]]; then
            echo "$TARGET/$base"
          else
            echo "$TARGET/.${base}"
          fi
          ;;
        home)
          echo "$TARGET/$base"
          ;;
        error)
          echo "__ERROR__"
          ;;
        *)
          # safe default
          if [[ "$base" == .* ]]; then
            echo "$TARGET/$base"
          else
            echo "$TARGET/.${base}"
          fi
          ;;
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
    # Build exclude list for files at module root that are mapped (we'll handle them
    # with explicit symlinks) — plus exclude etc/
    EXCLUDE_ARGS=(--exclude 'etc/')
    for mapped in "${!_MAPPED_NAMES[@]}"; do
      EXCLUDE_ARGS+=(--exclude "$mapped")
    done
    if command -v rsync >/dev/null 2>&1; then
      (cd "$(dirname "$MOD")" && rsync -a "${EXCLUDE_ARGS[@]}" "$(basename "$MOD")/" "$TMP_MOD_DIR/$TMP_NAME/")
    else
      # fallback: copy everything then remove excluded entries
      (cd "$(dirname "$MOD")" && cp -a "$(basename "$MOD")/" "$TMP_MOD_DIR/$TMP_NAME/" ) || true
      for ex in "${!_MAPPED_NAMES[@]}" etc; do
        rm -rf "$TMP_MOD_DIR/$TMP_NAME/$ex" || true
      done
    fi

    # Handle mapped root files (create proper XDG symlinks)
    for f in $(cd "$(dirname "$MOD")" && find "$(basename "$MOD")" -mindepth 1 -maxdepth 1 -type f -printf "%f\n" 2>/dev/null || true); do
      DEST=$(map_target "$f" "$BASENAME")
      # If file maps into a subdir of $HOME (XDG), create parent and symlink it
      # If mapping returned the IGNORE sentinel, skip creating a special mapping
      if [[ "$DEST" == "__IGNORE__" ]]; then
        echo "Skipping ignored root file: $f" >&2
        continue
      fi
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
