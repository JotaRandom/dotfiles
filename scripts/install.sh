#!/usr/bin/env bash
# Instalador mínimo para dotfiles del usuario (guiado por mapeos, sin herramienta externa para symlinks)

set -euo pipefail

usage(){
  cat <<EOF
Uso: $0 [modulo1 modulo2 ...]
Si no se especifican módulos, se instalará un conjunto predeterminado y seguro de módulos de dotfiles
para el usuario, sin modificar la configuración a nivel de sistema.

Este script instala los dotfiles en el directorio home del usuario actual usando las reglas de mapeo
definidas en install-mappings.yml. A diferencia de flujos previos, crea enlaces simbólicos explícitos
según los mapeos y el comportamiento de DEFAULT_ACTION (dotify/home/error).
La configuración a nivel de sistema (por ejemplo, archivos bajo /etc como Xorg) NO será modificada
por este script.
EOF
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  usage
  exit 0
fi

# Módulos predeterminados: solo dotfiles a nivel de usuario (directorio home)
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
  "modules/pacman"
  "modules/desktop/chrome"
  "modules/git"
  "modules/editor/nvim"
  "modules/editor/vscode"
  "modules/editor/emacs"
  "modules/editor/vim"
  "modules/editor/nano"
  "modules/editor/latex"
  "modules/terminal/alacritty"
  "modules/terminal/kitty"
)

if [[ $# -gt 0 ]]; then
  MODULES=("$@")
fi

echo "Instalando dependencias necesarias (git-lfs) si lo permiten el sistema (apt/pacman/dnf)..."
if command -v apt >/dev/null 2>&1; then
  sudo apt update && sudo apt install -y git-lfs || true
elif command -v pacman >/dev/null 2>&1; then
  sudo pacman -Syu --noconfirm git-lfs || true
elif command -v dnf >/dev/null 2>&1; then
  sudo dnf install -y git-lfs || true
  # TODO: Add dnf for slackware and other package managers
else
  echo "No se detectó gestor de paquetes compatible. Asegúrate de instalar 'git-lfs' manualmente."
fi

git lfs install || true

TARGET="${TARGET:-$HOME}"
echo "Usando target: $TARGET"

# Cargar reglas de mapeo si están disponibles (install-mappings.yml)
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
# Generar conjuntos rápidos de claves mapeadas
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
    echo "Preparando instalación: $BASENAME -> $TARGET"

    # Precaución: omitir módulos que contengan rutas a nivel de sistema (p. ej., etc/) porque este instalador
    # only operates on user-level files under $HOME. If you intentionally want to apply system
    # files, handle them manually (or run a separate system installer as root).
    if (cd "$(dirname "$MOD")" && find "$(basename "$MOD")" -mindepth 1 -maxdepth 2 -type f -path '*/etc/*' | read); then
      echo "Omitiendo módulo $BASENAME porque contiene archivos a nivel de sistema bajo 'etc/'." >&2
      echo "Este instalador no aplicará archivos destinados a /etc (p. ej., /etc/thinkfan.conf)." >&2
      continue
    fi

    # Auxiliar: mapear ruta destino usando solo valores de install-mappings.yml y DEFAULT_ACTION
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
      # Restablecer auxiliares/variables de salida
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

      # No hay mapeo presente — respetar DEFAULT_ACTION
      case "$DEFAULT_ACTION" in
        dotify)
          # dotify: crear un nombre con prefijo '.' en HOME a menos que ya comience con '.'
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

    # Verificación en seco: listar destinos en conflicto (considerar mapeos XDG)
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
      echo "Conflictos detectados al aplicar módulo $BASENAME:" >&2
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
    # Create a temporary sanitized module for install (exclude mapped root files and any etc/ entries)
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
    # If DEFAULT_ACTION is dotify, identify top-level entries we should dotify
    DOTIFY_BASENAMES=()
    if [[ "$DEFAULT_ACTION" == "dotify" ]]; then
      while IFS= read -r -d $'\0' top; do
        base="$(basename "$top")"
        # Skip already-dot-prefixed names and mapped basenames
        if [[ "${base}" == .* ]] || [[ -n "${_MAPPED_NAMES[$base]:-}" ]]; then
          continue
        fi
        DOTIFY_BASENAMES+=("$base")
        EXCLUDE_ARGS+=(--exclude "**/${base}")
        EXCLUDE_ARGS+=(--exclude "/${base}")
      done < <(cd "$(dirname "$MOD")" && find "$(basename "$MOD")" -mindepth 1 -maxdepth 1 -print0 2>/dev/null || true)
    fi
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
      echo "Mapeo: $found_rel => $DEST (explícito=${MAP_TARGET_EXPLICIT_TMP:-0}, clave=${MAP_TARGET_KEY_TMP:-})"
      # Only create explicit symlinks for files with explicit mappings in install-mappings.yml.
      if [ "${MAP_TARGET_EXPLICIT_TMP:-0}" -eq 0 ]; then
        continue
      fi
      # If file maps into a subdir of $HOME (XDG), create parent and symlink it
      # If mapping returned the IGNORE sentinel, skip creating a special mapping
      if [[ "$DEST" == "__IGNORE__" ]]; then
        echo "Archivo ignorado: $found_rel (omitido)" >&2
        continue
      fi
      # If mapping was provided by basename and multiple files share the same basename
      # we avoid ambiguous installation — require users to specify the relative path
      if [[ "${MAP_TARGET_KEY_TMP:-}" == base:* ]]; then
        count=$(cd "$(dirname "$MOD")" && find "$(basename "$MOD")" -type f -name "$fbase" | wc -l || true)
        if [ "$count" -gt 1 ]; then
          echo "Mapeo ambiguo: existen varios archivos llamados $fbase en el módulo $BASENAME; usa un mapeo por ruta relativa en install-mappings.yml para desambiguar." >&2
          continue
        fi
      fi
      # Always create symlink for explicit mappings (even if path equals default); this ensures
      # files are installed at XDG/explicit destinations even when excluded from the temporary module copy.
      if [ "${MAP_TARGET_EXPLICIT_TMP:-0}" -eq 1 ]; then
        if [ -L "$DEST" ] && [ "$(readlink -f "$DEST")" = "$(cd "$(dirname "$MOD")" && echo "$(pwd -P)/$found_rel")" ]; then
          echo "Omitiendo enlace simbólico ya existente: $DEST"
        else
          if [ -e "$DEST" ] || [ -L "$DEST" ]; then
            BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%s)/$BASENAME"
            mkdir -p "$(dirname "$BACKUP_DIR/$found_rel")" || true
            echo "Respaldando $DEST a $BACKUP_DIR/$found_rel"
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
                echo "Saneado CRLF -> LF y creado: $sanitized_src"
              fi
              break
            fi
          done
          echo "Creando enlace simbólico: $DEST -> $sanitized_src"
          ln -sf "$sanitized_src" "$DEST"
          map_created+=("$DEST")
        fi
      fi
    done < <(cd "$(dirname "$MOD")" && find "$(basename "$MOD")" -type f -print0 2>/dev/null || true)

    # If DEFAULT_ACTION is dotify, convert any top-level non-dot items in the temp module
    # into dot-prefixed names unless they are mapped by install-mappings.yml.
    if [[ "$DEFAULT_ACTION" == "dotify" ]]; then
      for ent in "$TMP_MOD_DIR/$TMP_NAME"/*; do
        [ -e "$ent" ] || continue
        base=$(basename "$ent")
        # Skip already-dot-prefixed names
        case "$base" in
          .* ) continue ;;
        esac
        # If this basename is a mapped name, skip dotifying
        if [[ -n "${_MAPPED_NAMES[$base]:-}" ]]; then
          continue
        fi
        # If target dot-name already exists in module, warn and skip
        dotpath="$TMP_MOD_DIR/$TMP_NAME/.$base"
        if [ -e "$dotpath" ]; then
          echo "Advertencia: no se dotificará $base porque .$base ya existe en el módulo $BASENAME" >&2
          continue
        fi
        # Rename (move) the entry to dot-prefixed name
        mv "$ent" "$dotpath" || true
      done
    fi

    # Remove any empty directories left by exclusions to avoid creating dotted-empty folders
    find "$TMP_MOD_DIR/$TMP_NAME" -type d -empty -delete || true

    echo "Aplicando módulo $BASENAME (desde copia saneada)"
    # Only run install if the temp module actually contains files after exclusions
    if (cd "$TMP_MOD_DIR" && find "$TMP_NAME" -mindepth 1 -print -quit | grep -q .); then
      # Manual symlink creation to avoid leaving dotless files in $HOME
      echo "Creando enlaces simbólicos para archivos en $TMP_NAME"
      while IFS= read -r -d $'\0' tmpf; do
        # trim leading './' produced by find and skip './' root
        rel=${tmpf#./}
        [ "$rel" = "." ] && continue
        # mapear al destino usando el auxiliar/función existente
        map_target "$rel" "$BASENAME"
        DEST="$MAP_TARGET_OUT"
        if [[ "$DEST" == "__IGNORE__" ]]; then
          continue
        fi
        # If explicit mapping, we already handled it earlier
        if [ "${MAP_TARGET_EXPLICIT:-0}" -eq 1 ]; then
          continue
        fi
        # Resolve source in repository. If top-level dotified entry exists only in tmp,
        # try origin without the dot (i.e., 'name' -> '.name' was dotified in tmp)
        repo_rel="$rel"
        if [[ "$repo_rel" == .* ]]; then
          # for top-level dotified names of the form '.foo' => try 'foo'
          # only alter the first path segment
          rest="${repo_rel#./}" || true
          non_dot="${repo_rel#.}"
          if [ -e "$MOD/$non_dot" ]; then
            repo_rel="$non_dot"
          fi
        fi
        SRC_ABS="$(cd "$(dirname "$MOD")" && printf '%s/%s' "$(pwd -P)" "$repo_rel")"
        # Skip directories (we'll create parents separately)
        if [ -d "$TMP_MOD_DIR/$TMP_NAME/$rel" ]; then
          mkdir -p "$DEST" || true
          continue
        fi
        # If destination exists and is the correct symlink, skip
        if [ -L "$DEST" ] && [ "$(readlink -f "$DEST")" = "$(readlink -f "$SRC_ABS")" ]; then
          continue
        fi
        # Respaldar destinos existentes que no sean enlaces simbólicos
        if [ -e "$DEST" ] && [ ! -L "$DEST" ]; then
          BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%s)/$BASENAME"
          mkdir -p "$(dirname "$BACKUP_DIR/$rel")" || true
          mv "$DEST" "$BACKUP_DIR/$rel" || true
        fi
        mkdir -p "$(dirname "$DEST")" || true
        # Some interactive startup files may have CRLF; reuse sanitize logic
        SANITIZE_BASENAMES=('.bashrc' '.profile' '.bash_profile' '.zshrc' '.bash_logout')
        base_name="$(basename "$rel")"
        sanitized_src="$SRC_ABS"
        for _s in "${SANITIZE_BASENAMES[@]}"; do
          if [[ "$_s" == "$base_name" ]]; then
            if grep -q $'\r' "$SRC_ABS" 2>/dev/null || head -c 1 -q "$SRC_ABS" | od -An -t x1 | grep -q '0d'; then
              SAN_DIR="$TARGET/.dotfiles_sanitized/$BASENAME/$(dirname "$rel")"
              mkdir -p "$SAN_DIR" || true
              SAN_PATH="$SAN_DIR/$base_name"
              if [ -x "$SRC_ABS" ]; then
                awk '{ sub("\r$", ""); print }' "$SRC_ABS" > "$SAN_PATH" && chmod +x "$SAN_PATH" || true
              else
                awk '{ sub("\r$", ""); print }' "$SRC_ABS" > "$SAN_PATH" || true
              fi
              sanitized_src="$SAN_PATH"
              echo "Saneado CRLF -> LF y creado: $sanitized_src"
            fi
            break
          fi
        done
        echo "Creando enlace simbólico: $DEST -> $sanitized_src"
        ln -sfn "$sanitized_src" "$DEST" || true
      done < <(cd "$TMP_MOD_DIR/$TMP_NAME" && find . -mindepth 1 -print0)
    else
      echo "Omitando módulo (nada que instalar tras las exclusiones): $BASENAME"
    fi
    # Create dot-prefixed symlinks for the identified DOTIFY_BASENAMES
    if [[ ${#DOTIFY_BASENAMES[@]} -gt 0 ]]; then
      for base in "${DOTIFY_BASENAMES[@]}"; do
        SRC_ABS="$(cd "$(dirname "$MOD")" && printf '%s/%s' "$(pwd -P)" "$base")"
        DEST="$TARGET/.${base}"
        # Skip if symlink already correct
        if [ -L "$DEST" ] && [ "$(readlink -f "$DEST")" = "$SRC_ABS" ]; then
          continue
        fi
        # Respaldar si existe y no es un enlace simbólico
        if [ -e "$DEST" ] && [ ! -L "$DEST" ]; then
          BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%s)/$BASENAME"
          mkdir -p "$(dirname "$BACKUP_DIR/$base")" || true
          mv "$DEST" "$BACKUP_DIR/$base" || true
        fi
        mkdir -p "$(dirname "$DEST")" || true
        ln -sfn "$SRC_ABS" "$DEST" || true
        echo "Creado enlace dotificado: $DEST -> $SRC_ABS"
      done
    fi
    # verify the explicit mapping destinations are symlinks, otherwise back them up and recreate
    for d in "${map_created[@]:-}"; do
      [ -z "$d" ] && continue
      if [ ! -L "$d" ]; then
        echo "Post-instalación: no se encontró un enlace simbólico en la ruta de mapeo $d — será respaldado y se recreará el enlace simbólico"
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
                echo "Post-instalación: Saneado CRLF -> LF y creado: $SANITED_SRC_TO_LINK"
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
