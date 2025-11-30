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

TARGET="${TARGET:-$HOME}"
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
# Build quick sets of mapped keys
declare -A _MAPPED_NAMES _MAPPED_RELS
for k in "${!_MAPPER_GLOBAL[@]}"; do
  _MAPPED_NAMES["$(basename "$k")"]=1
  if [[ "$k" == */* ]]; then
    _MAPPED_RELS["$k"]=1
  fi
done
for k in "${!_MAPPER_MODULE[@]}"; do
  name="${k%%|*}"
  _MAPPED_NAMES["$(basename "$name")"]=1
  if [[ "$name" == */* ]]; then
    _MAPPED_RELS["$name|${k##*|}" ]=1
  fi
done
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
      local srcfile module_name base mapping
      srcfile="$1"; module_name="$2"
      # Use XDG dirs when available, fall back to standard locations
      XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$TARGET/.config}"
      XDG_DATA_HOME="${XDG_DATA_HOME:-$TARGET/.local/share}"
      XDG_STATE_HOME="${XDG_STATE_HOME:-$TARGET/.local/state}"
      XDG_CACHE_HOME="${XDG_CACHE_HOME:-$TARGET/.cache}"
      # prefer declarative mapping from install-mappings.yml if present
      base="$(basename "$srcfile")"
      # Prefer exact relative-path match in per-module mappings
      if [[ -n "${_MAPPER_MODULE["$srcfile|$module_name"]+x}" ]]; then
        mapping="${_MAPPER_MODULE["$srcfile|$module_name"]}"
        MAP_TARGET_EXPLICIT=1
        MAP_TARGET_KEY="rel:$srcfile"
      elif [[ -n "${_MAPPER_MODULE["$base|$module_name"]+x}" ]]; then
        mapping="${_MAPPER_MODULE["$base|$module_name"]}"
        MAP_TARGET_EXPLICIT=1
        MAP_TARGET_KEY="base:$base"
      elif [[ -n "${_MAPPER_GLOBAL["$srcfile"]+x}" ]]; then
        mapping="${_MAPPER_GLOBAL["$srcfile"]}"
        MAP_TARGET_EXPLICIT=1
        MAP_TARGET_KEY="rel:$srcfile"
      elif [[ -n "${_MAPPER_GLOBAL["$base"]+x}" ]]; then
        mapping="${_MAPPER_GLOBAL["$base"]}"
        MAP_TARGET_EXPLICIT=1
        MAP_TARGET_KEY="base:$base"
      else
        mapping=""
        MAP_TARGET_EXPLICIT=0
        MAP_TARGET_KEY=""
      fi
      # Reset output helpers
      MAP_TARGET_OUT=""
      MAP_TARGET_EXPLICIT=0
      MAP_TARGET_KEY=""
      if [ -n "$mapping" ]; then
        # allow special sentinel values in mapping like 'ignore' or 'skip' to indicate
        # "do not create a mapping / link for this root file"
        if [[ "$mapping" =~ ^(ignore|skip)$ ]]; then
          echo "__IGNORE__"
          return
        fi
        case "$mapping" in
          xdg:*) MAP_TARGET_OUT="${XDG_CONFIG_HOME}/${mapping#xdg:}"; MAP_TARGET_EXPLICIT=1; MAP_TARGET_KEY="${mapping}"; return;;
          xdg_state:*) echo "${XDG_STATE_HOME}/${mapping#xdg_state:}"; return;;
          xdg_data:*) echo "${XDG_DATA_HOME}/${mapping#xdg_data:}"; return;;
          xdg_cache:*) echo "${XDG_CACHE_HOME}/${mapping#xdg_cache:}"; return;;
          home:*) MAP_TARGET_OUT="$TARGET/${mapping#home:}"; MAP_TARGET_EXPLICIT=1; MAP_TARGET_KEY="${mapping}"; return;;
          *) MAP_TARGET_OUT="$TARGET/$srcfile"; MAP_TARGET_EXPLICIT=1; MAP_TARGET_KEY="${mapping}"; return;;
        esac
      fi

      # No mapping present — obey DEFAULT_ACTION
      case "$DEFAULT_ACTION" in
        dotify)
          # dotify: create a dot-prefixed name in HOME unless it already starts with '.'
          if [[ "$base" == .* ]]; then
            MAP_TARGET_OUT="$TARGET/$base"
          else
            MAP_TARGET_OUT="$TARGET/.${base}"
          fi
          MAP_TARGET_EXPLICIT=0; MAP_TARGET_KEY="default:$base"
          ;;
        home)
          MAP_TARGET_OUT="$TARGET/$base"; MAP_TARGET_EXPLICIT=0; MAP_TARGET_KEY="default:$base"
          ;;
        error)
          MAP_TARGET_OUT="__ERROR__"; MAP_TARGET_EXPLICIT=0; MAP_TARGET_KEY="default:error"
          ;;
        *)
          # safe default
            if [[ "$base" == .* ]]; then
              MAP_TARGET_OUT="$TARGET/$base"
            else
              MAP_TARGET_OUT="$TARGET/.${base}"
            fi
            MAP_TARGET_EXPLICIT=0; MAP_TARGET_KEY="default:$base"
          ;;
      esac
      # ensure MAP_TARGET_OUT is set at exit
    }

    # dry-run check: list conflicting targets (consider XDG mappings)
    CONFLICTS=()
    while IFS= read -r -d $'\0' SRC; do
      # compute REL relative to the module root (strip the module folder prefix)
      REL=${SRC#"${BASENAME}"/}
      map_target "$REL" "$BASENAME"
      TARGET_PATH="$MAP_TARGET_OUT"
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

    # Detect mapped files anywhere within the module (not only at root) and
    # create proper XDG/home symlinks. Then exclude them from the module copy.
    # Create a temporary sanitized module for stow (exclude mapped root files and any etc/ entries)
    TMP_MOD_DIR="$(mktemp -d)"
    TMP_NAME="${BASENAME}.tmp"
    mkdir -p "$TMP_MOD_DIR/$TMP_NAME"
    # Copy module contents but exclude files at root that map to other locations and exclude etc/
    # Build exclude list for files at module root that are mapped (we'll handle them
    # with explicit symlinks) — plus exclude etc/
    EXCLUDE_ARGS=(--exclude '/etc/')
    # Exclude only matching mapped files; support both exact relative paths and basenames.
    for rel in "${!_MAPPED_RELS[@]}"; do
      # if this is module-specific mapping (format 'rel|module'), split it out and ensure matches module
      if [[ "$rel" == *"|"* ]]; then
        rel_key="${rel%%|*}"
        rel_mod="${rel##*|}"
        if [[ "$rel_mod" != "$BASENAME" ]]; then
          continue
        fi
        EXCLUDE_ARGS+=(--exclude "/${rel_key}")
      else
        EXCLUDE_ARGS+=(--exclude "/${rel}")
      fi
    done
    for mapped in "${!_MAPPED_NAMES[@]}"; do
      # exclude any occurrences of the mapped basename anywhere in the module tree
      EXCLUDE_ARGS+=(--exclude "**/${mapped}")
      # exclude any top-level occurrence as well
      EXCLUDE_ARGS+=(--exclude "/${mapped}")
    done
    if command -v rsync >/dev/null 2>&1; then
      (cd "$(dirname "$MOD")" && rsync -a "${EXCLUDE_ARGS[@]}" "$(basename "$MOD")/" "$TMP_MOD_DIR/$TMP_NAME/")
    else
      # fallback: copy everything then remove excluded entries
      (cd "$(dirname "$MOD")" && cp -a "$(basename "$MOD")/" "$TMP_MOD_DIR/$TMP_NAME/" ) || true
      # Remove only mapped files (root-level and nested basenames) and the etc/ directory from the copied temp
      for ex in "${!_MAPPED_NAMES[@]}"; do
        find "${TMP_MOD_DIR}/${TMP_NAME}" -name "$ex" -exec rm -f {} + || true
      done
      for rel in "${!_MAPPED_RELS[@]}"; do
        # split per-module entries
        if [[ "$rel" == *"|"* ]]; then
          rkey="${rel%%|*}"
          rmodule="${rel##*|}"
          if [[ "$rmodule" != "$BASENAME" ]]; then
            continue
          fi
          rm -rf "${TMP_MOD_DIR:?}/${TMP_NAME:?}/${rkey:?}" || true
        else
          rm -rf "${TMP_MOD_DIR:?}/${TMP_NAME:?}/${rel:?}" || true
        fi
      done
      rm -rf "${TMP_MOD_DIR:?}/${TMP_NAME:?}/etc" || true
    fi

    # Handle mapped files found anywhere within the module (create proper XDG symlinks)
    # We'll attempt to match per-module mapping first, then fall back to global mapping
    # For basename-only mappings, search for a single occurrence inside the module
    map_created=()
    while IFS= read -r -d $'\0' found; do
      # compute relative path from module folder
      found_rel=${found#"$(dirname "$MOD")/$(basename "$MOD")/"}
      fbase=$(basename "$found_rel")
      map_target "$found_rel" "$BASENAME"
      DEST="$MAP_TARGET_OUT"
      MAP_TARGET_EXPLICIT_TMP=${MAP_TARGET_EXPLICIT:-0}
      MAP_TARGET_KEY_TMP=${MAP_TARGET_KEY:-}
      echo "Mapping: $found_rel => $DEST (explicit=${MAP_TARGET_EXPLICIT_TMP:-0}, key=${MAP_TARGET_KEY_TMP:-})"
      # Only create explicit symlinks for files with explicit mappings in install-mappings.yml.
      if [ "${MAP_TARGET_EXPLICIT_TMP:-0}" -eq 0 ]; then
        continue
      fi
      # If file maps into a subdir of $HOME (XDG), create parent and symlink it
      # If mapping returned the IGNORE sentinel, skip creating a special mapping
      if [[ "$DEST" == "__IGNORE__" ]]; then
        echo "Skipping ignored file: $found_rel" >&2
        continue
      fi
      # If mapping was provided by basename and multiple files share the same basename
      # we avoid ambiguous installation — require users to specify the relative path
      if [[ "${MAP_TARGET_KEY_TMP:-}" == base:* ]]; then
        count=$(cd "$(dirname "$MOD")" && find "$(basename "$MOD")" -type f -name "$fbase" | wc -l || true)
        if [ "$count" -gt 1 ]; then
          echo "Ambiguous mapping: multiple files named $fbase exist in module $BASENAME; please use a relative-path mapping in install-mappings.yml to disambiguate." >&2
          continue
        fi
      fi
      # Always create symlink for explicit mappings (even if path equals default); this ensures
      # files are installed at XDG/explicit destinations even when excluded from stow.
      if [ "${MAP_TARGET_EXPLICIT_TMP:-0}" -eq 1 ]; then
        if [ -L "$DEST" ] && [ "$(readlink -f "$DEST")" = "$(cd "$(dirname "$MOD")" && echo "$(pwd -P)/$found_rel")" ]; then
          echo "Skipping already-present symlink: $DEST"
        else
          if [ -e "$DEST" ] || [ -L "$DEST" ]; then
            BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%s)/$BASENAME"
            mkdir -p "$(dirname "$BACKUP_DIR/$found_rel")" || true
            echo "Backing up existing $DEST to $BACKUP_DIR/$found_rel"
            mv "$DEST" "$BACKUP_DIR/$found_rel" || true
          fi
          mkdir -p "$(dirname "$DEST")" || true
          # debug prints removed in production
          SRC_ABS="$(cd "$(dirname "$MOD")" && printf '%s/%s' "$(pwd -P)" "$found_rel")"
          # Some interactive startup files (e.g., .bashrc, .zshrc, .profile) may have CRLF
          # line endings. Shells may error on $'\r' tokens. To avoid breaking interactive shells,
          # create a sanitized LF-only copy under $TARGET/.dotfiles_sanitized when a CRLF is
          # detected, and symlink mapping targets to that sanitized copy. This preserves the
          # repo as-is while providing a usable environment.
          SANITIZE_BASENAMES=(".bashrc" ".profile" ".bash_profile" ".zshrc" ".bash_logout")
          base_name="$(basename "$found_rel")"
          sanitized_src="$SRC_ABS"
          for _s in "${SANITIZE_BASENAMES[@]}"; do
            if [[ "$_s" == "$base_name" ]]; then
              # detect CRLF (Carriage Return bytes) in source file
              if grep -q $'\r' "$SRC_ABS" 2>/dev/null || head -c 1 -q "$SRC_ABS" | od -An -t x1 | grep -q '0d'; then
                SAN_DIR="$TARGET/.dotfiles_sanitized/$BASENAME/$(dirname "$found_rel")"
                mkdir -p "$SAN_DIR" || true
                SAN_PATH="$SAN_DIR/$base_name"
                # Convert CRLF -> LF safely into sanitized path; preserve executable bit
                if [ -x "$SRC_ABS" ]; then
                  awk '{ sub("\r$", ""); print }' "$SRC_ABS" > "$SAN_PATH" && chmod +x "$SAN_PATH" || true
                else
                  awk '{ sub("\r$", ""); print }' "$SRC_ABS" > "$SAN_PATH" || true
                fi
                sanitized_src="$SAN_PATH"
                echo "Sanitized CRLF -> LF and created: $sanitized_src"
              fi
              break
            fi
          done
          echo "Creating symlink: $DEST -> $sanitized_src"
          ln -sf "$sanitized_src" "$DEST"
          map_created+=("$DEST")
        fi
      fi
    done < <(cd "$(dirname "$MOD")" && find "$(basename "$MOD")" -type f -print0 2>/dev/null || true)

    echo "stow -v -t $TARGET $TMP_NAME"
    echo "Aplicando module $BASENAME (via sanitized copy)"
    (cd "$TMP_MOD_DIR"; stow -v -t "$TARGET" "$TMP_NAME") || true
    # verify the explicit mapping destinations are symlinks, otherwise back them up and recreate
    for d in "${map_created[@]:-}"; do
      [ -z "$d" ] && continue
      if [ ! -L "$d" ]; then
        echo "Post-stow: non-symlink found at mapping destination $d — backing up and recreating symlink"
        if [ -e "$d" ]; then
          BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%s)/$BASENAME"
          mkdir -p "$(dirname "$BACKUP_DIR/${d#${TARGET}/}")" || true
          mv "$d" "$BACKUP_DIR/${d#${TARGET}/}" || true
        fi
        # attempt to recreate symlink (try to find source by filename inside the module)
        fname="$(basename "$d")"
        found_src=$(cd "$(dirname "$MOD")" && find "$(basename "$MOD")" -type f -name "$fname" -print -quit || true)
        if [ -n "$found_src" ]; then
          SRC_ABS="$(cd "$(dirname "$MOD")" && printf '%s/%s' "$(pwd -P)" "$found_src")"
          # same sanitize behavior as above: if the source is one of the interactive startups
          # and contains CRLF, write sanitized copy under $TARGET/.dotfiles_sanitized and link to it
          SANITED_SRC_TO_LINK="$SRC_ABS"
          for _s in "${SANITIZE_BASENAMES[@]:-.bashrc .profile .bash_profile .zshrc .bash_logout}"; do
            if [[ "${_s}" == "$(basename "$found_src")" ]]; then
              if grep -q $'\r' "$SRC_ABS" 2>/dev/null || head -c 1 -q "$SRC_ABS" | od -An -t x1 | grep -q '0d'; then
                SAN_DIR="$TARGET/.dotfiles_sanitized/$BASENAME/$(dirname "$found_src")"
                mkdir -p "$SAN_DIR" || true
                SAN_PATH="$SAN_DIR/$(basename "$found_src")"
                if [ -x "$SRC_ABS" ]; then
                  awk '{ sub("\r$", ""); print }' "$SRC_ABS" > "$SAN_PATH" && chmod +x "$SAN_PATH" || true
                else
                  awk '{ sub("\r$", ""); print }' "$SRC_ABS" > "$SAN_PATH" || true
                fi
                SANITED_SRC_TO_LINK="$SAN_PATH"
                echo "Post-stow sanitized CRLF -> LF and created: $SANITED_SRC_TO_LINK"
              fi
              break
            fi
          done
          ln -sfn "$SANITED_SRC_TO_LINK" "$d" || true
        fi
      fi
    done
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
