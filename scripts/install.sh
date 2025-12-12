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
  "modules/browsers/chrome"
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

# Resolver la raíz del repositorio y normalizar rutas para que el script funcione
# aunque se ejecute desde un CWD distinto al root del repo. Preferimos usar git
# para descubrir la raíz; si no hay git, usar la ubicación del script.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || (cd "$SCRIPT_DIR/.." && pwd -P))"
# Asegurarnos de operar desde la raíz del repositorio para evitar comportamientos
# diferentes según el CWD desde el que se invoque el script.
cd "$REPO_ROOT" || true

# Normalizar entradas de MODULES a rutas absolutas dentro del repo para evitar
# depender del directorio de trabajo actual.
  for i in "${!MODULES[@]}"; do
  entry="${MODULES[i]}"
  # si la entrada ya es absoluta, dejarla como está
  if [[ "$entry" = /* ]]; then
    MODULES[i]="$entry"
  else
    MODULES[i]="$REPO_ROOT/$entry"
  fi
done

echo "Instalando dependencias necesarias (git-lfs) si lo permiten el sistema (apt/pacman/dnf)..."
if command -v apt >/dev/null 2>&1; then
  sudo apt update && sudo apt install -y git-lfs || true
elif command -v pacman >/dev/null 2>&1; then
  sudo pacman -Syu --noconfirm --needed git-lfs || true
elif command -v dnf >/dev/null 2>&1; then
  sudo dnf install -y git-lfs || true
elif command -v slackpkg >/dev/null 2>&1; then
  # Slackware-style systems: intentamos usar slackpkg si está disponible
  sudo slackpkg update && sudo slackpkg install -y git-lfs || true
elif command -v sbopkg >/dev/null 2>&1; then
  # sbopkg (SlackBuilds) puede usarse para construir paquetes de fuente; intentamos instalar git-lfs si hay un sbopkg instalable
  sudo sbopkg -i git-lfs || true
  # Si no funciona, el usuario puede instalar git-lfs manualmente (installpkg / pkgtool)
else
  echo "No se detectó gestor de paquetes compatible. Asegúrate de instalar 'git-lfs' manualmente."
fi

git lfs install || true

TARGET="${TARGET:-$HOME}"
echo "Usando target: $TARGET"

# Cargar reglas de mapeo si están disponibles (install-mappings.yml)
declare -A _MAPPER_GLOBAL _MAPPER_MODULE
DEFAULT_ACTION="dotify"
MAPPINGS_FILE="$REPO_ROOT/install-mappings.yml"
if [ -f "$MAPPINGS_FILE" ]; then
  # Leer todo el fichero en memoria para soportar listas YAML (clave: \n  - item)
  mapfile -t _map_lines < "$MAPPINGS_FILE"
  i=0
  while [ $i -lt ${#_map_lines[@]} ]; do
    line="${_map_lines[$i]}"
    # eliminar comentarios
    line="${line%%#*}"
    # recortar
    line="${line#"${line%%[![:space:]]*}"}"
    line="${line%"${line##*[![:space:]]}"}"
    [ -z "$line" ] && { i=$((i+1)); continue; }
    if [[ "$line" =~ ^default_action:[[:space:]]*([a-zA-Z_]+) ]]; then
      DEFAULT_ACTION="${BASH_REMATCH[1]}"
      i=$((i+1)); continue
    fi

    if [[ "$line" =~ ^([^:]+):[[:space:]]*(.+)$ ]]; then
      key="${BASH_REMATCH[1]}"; val="${BASH_REMATCH[2]}"
      # recortar espacios
      key="${key#"${key%%[![:space:]]*}"}"; key="${key%"${key##*[![:space:]]}"}"
      val="${val#"${val%%[![:space:]]*}"}"; val="${val%"${val##*[![:space:]]}"}"
    elif [[ "$line" =~ ^([^:]+):[[:space:]]*$ ]]; then
      # clave seguida de una lista YAML indentada
      key="${BASH_REMATCH[1]}"
      vals=""
      j=$((i+1))
      while [ $j -lt ${#_map_lines[@]} ]; do
        nxt="${_map_lines[$j]}"
        nxt="${nxt%%#*}"
        nxt="${nxt#"${nxt%%[![:space:]]*}"}"
        nxt="${nxt%"${nxt##*[![:space:]]}"}"
        if [[ "$nxt" =~ ^-[[:space:]]*(.+)$ ]]; then
          item="${BASH_REMATCH[1]}"
          item="${item#"${item%%[![:space:]]*}"}"; item="${item%"${item##*[![:space:]]}"}"
          if [ -z "$vals" ]; then vals="$item"; else vals+=",$item"; fi
          j=$((j+1)); continue
        fi
        break
      done
      val="$vals"
      # avanzar el índice principal hasta la última línea procesada
      i=$((j-1))
    else
      i=$((i+1)); continue
    fi

    # mapeo específico por módulo: nombre|módulo
    if [[ "$key" == *"|"* ]]; then
      name="${key%%|*}"; mod="${key##*|}"
      k="$name|$mod"
      if [[ -n "${_MAPPER_MODULE[$k]+x}" ]]; then
        _MAPPER_MODULE["$k"]="${_MAPPER_MODULE[$k]},${val}"
      else
        _MAPPER_MODULE["$k"]="$val"
      fi
    else
      if [[ -n "${_MAPPER_GLOBAL[$key]+x}" ]]; then
        _MAPPER_GLOBAL["$key"]="${_MAPPER_GLOBAL[$key]},${val}"
      else
        _MAPPER_GLOBAL["$key"]="$val"
      fi
    fi
    i=$((i+1))
  done
fi
# Generar conjuntos rápidos de claves mapeadas
declare -A _MAPPED_NAMES _MAPPED_RELS
for k in "${!_MAPPER_GLOBAL[@]}"; do
  _MAPPED_NAMES["$(basename -- "$k")"]=1
  if [[ "$k" == */* ]]; then
    _MAPPED_RELS["$k"]=1
  fi
done
for k in "${!_MAPPER_MODULE[@]}"; do
  name="${k%%|*}"
  _MAPPED_NAMES["$(basename -- "$name")"]=1
  if [[ "$name" == */* ]]; then
    _MAPPED_RELS["$name|${k##*|}" ]=1
  fi
done
for MOD in "${MODULES[@]}"; do
  declare -A _ALREADY_MAPPED=()
  if [ -d "$MOD" ]; then
    BASENAME=$(basename -- "$MOD")
    echo "Preparando instalación: $BASENAME -> $TARGET"

    # Precaución: omitir módulos que contengan rutas a nivel de sistema (p. ej., etc/) porque este instalador
    # opera únicamente sobre archivos a nivel de usuario bajo $HOME. Si quieres aplicar archivos de sistema,
    # hazlo manualmente (o ejecuta un instalador a nivel de sistema como root).
    if (cd "$(dirname "$MOD")" && find "$(basename -- "$MOD")" -mindepth 1 -maxdepth 2 -type f -path '*/etc/*' | read -r); then
      echo "Omitiendo módulo $BASENAME porque contiene archivos a nivel de sistema bajo 'etc/'." >&2
      echo "Este instalador no aplicará archivos destinados a /etc (p. ej., /etc/thinkfan.conf)." >&2
      continue
    fi

    # Auxiliar: mapear ruta destino usando solo valores de install-mappings.yml y DEFAULT_ACTION
    map_target(){
      local srcfile module_name base mapping
      srcfile="$1"; module_name="$2"
      # Usar directorios XDG cuando estén disponibles; en caso contrario, usar ubicaciones estándar
      XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$TARGET/.config}"
      XDG_DATA_HOME="${XDG_DATA_HOME:-$TARGET/.local/share}"
      XDG_STATE_HOME="${XDG_STATE_HOME:-$TARGET/.local/state}"
      XDG_CACHE_HOME="${XDG_CACHE_HOME:-$TARGET/.cache}"
      # preferir el mapeo declarativo desde install-mappings.yml si está presente
      base="$(basename -- "$srcfile")"
      # Preferir coincidencia exacta por ruta relativa en mapeos por módulo
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
        # permitir valores centinela especiales en los mapeos como 'ignore' o 'skip' para indicar
        # "no crear un mapeo / enlace para este archivo raíz"
        if [[ "$mapping" =~ ^(ignore|skip)$ ]]; then
          echo "__IGNORE__"
          return
        fi
        # soportar múltiples destinos separados por comas: "xdg:chrome/flags,xdg:chromium/flags"
        if [[ "$mapping" == *,* ]]; then
          MAP_TARGET_OUT="__MULTI__:${mapping}"
          MAP_TARGET_EXPLICIT=1
          MAP_TARGET_KEY="${mapping}"
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

      # Helper: resolver una especificación de mapeo individual a una ruta absoluta
      mapping_spec_to_path(){
        local spec="$1" module_name="$2" out=""
        case "$spec" in
          xdg:*) out="${XDG_CONFIG_HOME}/${spec#xdg:}" ;; 
          xdg_state:*) out="${XDG_STATE_HOME}/${spec#xdg_state:}" ;; 
          xdg_data:*) out="${XDG_DATA_HOME}/${spec#xdg_data:}" ;; 
          xdg_cache:*) out="${XDG_CACHE_HOME}/${spec#xdg_cache:}" ;; 
          home:*) out="$TARGET/${spec#home:}" ;; 
          *) out="$TARGET/$spec" ;;
        esac
        printf '%s' "$out"
      }

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
          # predeterminado seguro
            if [[ "$base" == .* ]]; then
              MAP_TARGET_OUT="$TARGET/$base"
            else
              MAP_TARGET_OUT="$TARGET/.${base}"
            fi
            MAP_TARGET_EXPLICIT=0; MAP_TARGET_KEY="default:$base"
          ;;
      esac
      # asegurar que MAP_TARGET_OUT esté establecido al salir
    }

    # Verificación en seco: listar destinos en conflicto (considerar mapeos XDG)
    CONFLICTS=()
    while IFS= read -r -d $'\0' SRC; do
      # calcular REL relativo a la raíz del módulo (eliminar prefijo de la carpeta del módulo)
      REL=${SRC#"${BASENAME}"/}
      map_target "$REL" "$BASENAME"
      TARGET_PATH="$MAP_TARGET_OUT"
      if [ -e "$TARGET_PATH" ] || [ -L "$TARGET_PATH" ]; then
        # si es un enlace simbólico que apunta al mismo destino, omitir
        if [ -L "$TARGET_PATH" ]; then
          if [ "$(readlink -f "$TARGET_PATH")" = "$(readlink -f "$MOD/$REL")" ]; then
            continue
          fi
        fi
        CONFLICTS+=("$TARGET_PATH")
      fi
    done < <(cd "$(dirname "$MOD")" && find "$(basename -- "$MOD")" -mindepth 1 -print0)

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

    # Detectar ficheros mapeados en cualquier parte del módulo (no solo en la raíz) y
    # crear los enlaces simbólicos XDG/~/HOME correctos. Luego excluirlos de la copia
    # temporal del módulo.
    # Crear un módulo temporal saneado para la instalación (excluir ficheros mapeados en raíz y cualquier entrada etc/)
    TMP_MOD_DIR="$(mktemp -d)"
    TMP_NAME="${BASENAME}.tmp"
    mkdir -p "$TMP_MOD_DIR/$TMP_NAME"
    # Copiar el contenido del módulo pero excluir los ficheros a nivel raíz que se mapean
    # a otras ubicaciones y excluir también la carpeta etc/
    # Construir la lista de exclusión para archivos situada en la raíz del módulo que estén mapeados
    # (los manejaremos con enlaces simbólicos explícitos) — además excluir etc/
    EXCLUDE_ARGS=(--exclude '/etc/')
    # Excluir solo ficheros mapeados coincidentes; soportar rutas relativas exactas y nombres base.
    for rel in "${!_MAPPED_RELS[@]}"; do
      # si este es un mapeo específico por módulo (formato 'rel|module'), dividirlo y asegurar que coincida con el módulo
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
      # excluir cualquier ocurrencia del nombre base mapeado en cualquier parte del árbol del módulo
      EXCLUDE_ARGS+=(--exclude "**/${mapped}")
      # exclude any top-level occurrence as well
      EXCLUDE_ARGS+=(--exclude "/${mapped}")
    done
    # Si DEFAULT_ACTION es 'dotify', identificar entradas top-level que deberíamos dotificar
    DOTIFY_BASENAMES=()
    if [[ "$DEFAULT_ACTION" == "dotify" ]]; then
      while IFS= read -r -d $'\0' top; do
        base="$(basename -- "$top")"
        # Omitir nombres que ya comienzan con '.' y nombres base que estén mapeados
        if [[ "${base}" == .* ]] || [[ -n "${_MAPPED_NAMES[$base]:-}" ]]; then
          continue
        fi
        DOTIFY_BASENAMES+=("$base")
        EXCLUDE_ARGS+=(--exclude "**/${base}")
        EXCLUDE_ARGS+=(--exclude "/${base}")
      done < <(cd "$(dirname "$MOD")" && find "$(basename -- "$MOD")" -mindepth 1 -maxdepth 1 -print0 2>/dev/null || true)
    fi
    if command -v rsync >/dev/null 2>&1; then
      (cd "$(dirname "$MOD")" && rsync -a "${EXCLUDE_ARGS[@]}" "$(basename -- "$MOD")/" "$TMP_MOD_DIR/$TMP_NAME/")
    else
      # fallback: copiar todo el módulo y luego eliminar las entradas excluidas
      (cd "$(dirname "$MOD")" && cp -a "$(basename -- "$MOD")/" "$TMP_MOD_DIR/$TMP_NAME/" ) || true
      # Eliminar solo ficheros mapeados (a nivel raíz y nombres base anidados) y el directorio etc/ de la copia temporal
      for ex in "${!_MAPPED_NAMES[@]}"; do
        find "${TMP_MOD_DIR}/${TMP_NAME}" -name "$ex" -exec rm -f {} + || true
      done
      for rel in "${!_MAPPED_RELS[@]}"; do
        # dividir entradas por módulo
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

    # Manejar ficheros mapeados encontrados en cualquier parte del módulo (crear enlaces simbólicos XDG apropiados)
    # Intentaremos coincidir primero con mapeos por módulo, y luego volver al mapeo global
    # Para mapeos por nombre base, buscar una única coincidencia dentro del módulo
    map_created=()
    while IFS= read -r -d $'\0' found; do
      # compute relative path from module folder
      found_rel=${found#"$(dirname -- "$MOD")/$(basename -- "$MOD")/"}
      fbase=$(basename -- "$found_rel")
      map_target "$found_rel" "$BASENAME"
      DEST="$MAP_TARGET_OUT"
      MAP_TARGET_EXPLICIT_TMP=${MAP_TARGET_EXPLICIT:-0}
      MAP_TARGET_KEY_TMP=${MAP_TARGET_KEY:-}
      echo "Mapeo: $found_rel => $DEST (explícito=${MAP_TARGET_EXPLICIT_TMP:-0}, clave=${MAP_TARGET_KEY_TMP:-})"
      # Solo crear enlaces simbólicos explícitos para archivos con mapeos declarados en install-mappings.yml.
      if [ "${MAP_TARGET_EXPLICIT_TMP:-0}" -eq 0 ]; then
        continue
      fi
      # Si el archivo se mapea dentro de un subdirectorio de $HOME (XDG), crear el directorio padre y el enlace
      # Si el mapeo devuelve el centinela IGNORE, omitir la creación de un mapeo especial
      if [[ "$DEST" == "__IGNORE__" ]]; then
        echo "Archivo ignorado: $found_rel (omitido)" >&2
        continue
      fi
      # Si el mapeo se proporcionó por nombre base y varios archivos comparten ese nombre
      # evitamos instalaciones ambiguas — requerir que el usuario especifique la ruta relativa para desambiguar
      if [[ "${MAP_TARGET_KEY_TMP:-}" == base:* ]]; then
        count=$(cd "$(dirname -- "$MOD")" && find "$(basename -- "$MOD")" -type f -name "$fbase" | wc -l || true)
        if [ "$count" -gt 1 ]; then
          echo "Mapeo ambiguo: existen varios archivos llamados $fbase en el módulo $BASENAME; usa un mapeo por ruta relativa en install-mappings.yml para desambiguar." >&2
          continue
        fi
      fi
      # Siempre crear enlace simbólico para mapeos explícitos (incluso si la ruta coincide con la predeterminada); esto asegura
      # que los archivos se instalen en destinos XDG/explicados aunque estén excluidos de la copia temporal del módulo.
      # los archivos se instalan en destinos XDG/explicados incluso cuando están excluidos de la copia temporal del módulo.
      if [ "${MAP_TARGET_EXPLICIT_TMP:-0}" -eq 1 ]; then
        # Soporte para mapeos múltiples separados por comas
        if [[ "${MAP_TARGET_KEY_TMP:-}" == *,* ]]; then
          specs="${MAP_TARGET_KEY_TMP}"
          specs="${specs#__MULTI__:}"
          IFS=',' read -ra SPEC_ARR <<< "$specs"
          for spec in "${SPEC_ARR[@]}"; do
            spec_trimmed="$(echo "$spec" | sed -e 's/^\s*//' -e 's/\s*$//')"
            DEST_PATH="$(mapping_spec_to_path "$spec_trimmed" "$BASENAME")"
            if [ -L "$DEST_PATH" ] && [ "$(readlink -f "$DEST_PATH")" = "$(cd "$(dirname "$MOD")" && echo "$(pwd -P)/$found_rel")" ]; then
              echo "Omitiendo enlace simbólico ya existente: $DEST_PATH"
              continue
            fi
            if [ -e "$DEST_PATH" ] || [ -L "$DEST_PATH" ]; then
              BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%s)/$BASENAME"
              mkdir -p "$(dirname "$BACKUP_DIR/$found_rel")" || true
              echo "Respaldando $DEST_PATH a $BACKUP_DIR/$found_rel"
              mv "$DEST_PATH" "$BACKUP_DIR/$found_rel" || true
            fi
            mkdir -p "$(dirname "$DEST_PATH")" || true
            SRC_ABS="$(cd "$(dirname "$MOD")" && printf '%s/%s' "$(pwd -P)" "$found_rel")"
            SANITIZE_BASENAMES=(".bashrc" ".profile" ".bash_profile" ".zshrc" ".bash_logout")
            base_name="$(basename -- "$found_rel")"
            sanitized_src="$SRC_ABS"
            for _s in "${SANITIZE_BASENAMES[@]}"; do
              if [[ "$_s" == "$base_name" ]]; then
                if grep -q $'\r' "$SRC_ABS" 2>/dev/null || head -c 1 -q "$SRC_ABS" | od -An -t x1 | grep -q '0d'; then
                  SAN_DIR="$TARGET/.dotfiles_sanitized/$BASENAME/$(dirname "$found_rel")"
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
            echo "Creando enlace simbólico: $DEST_PATH -> $sanitized_src"
            ln -sf "$sanitized_src" "$DEST_PATH"
            map_created+=("$DEST_PATH")
          done
        else
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
            SRC_ABS="$(cd "$(dirname "$MOD")" && printf '%s/%s' "$(pwd -P)" "$found_rel")"
            SANITIZE_BASENAMES=(".bashrc" ".profile" ".bash_profile" ".zshrc" ".bash_logout")
            base_name="$(basename -- "$found_rel")"
            sanitized_src="$SRC_ABS"
            for _s in "${SANITIZE_BASENAMES[@]}"; do
              if [[ "$_s" == "$base_name" ]]; then
                if grep -q $'\r' "$SRC_ABS" 2>/dev/null || head -c 1 -q "$SRC_ABS" | od -An -t x1 | grep -q '0d'; then
                  SAN_DIR="$TARGET/.dotfiles_sanitized/$BASENAME/$(dirname "$found_rel")"
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
            ln -sf "$sanitized_src" "$DEST"
            map_created+=("$DEST")
          fi
        fi
      fi
    done < <(cd "$(dirname -- "$MOD")" && find "$(basename -- "$MOD")" -type f -print0 2>/dev/null || true)

    # Si DEFAULT_ACTION es 'dotify', convertir cualquier entrada top-level sin punto en el módulo temporal
    # a nombres con prefijo '.' a menos que estén mapeadas por install-mappings.yml.
    if [[ "$DEFAULT_ACTION" == "dotify" ]]; then
      for ent in "$TMP_MOD_DIR/$TMP_NAME"/*; do
        [ -e "$ent" ] || continue
        base=$(basename -- "$ent")
        # Omitir nombres que ya comienzan con '.'
        case "$base" in
          .* ) continue ;;
        esac
        # Si este nombre base está mapeado, omitir el proceso de dotify
        if [[ -n "${_MAPPED_NAMES[$base]:-}" ]]; then
          continue
        fi
        # Si el nombre con '.' ya existe en el módulo, advertir y omitir
        dotpath="$TMP_MOD_DIR/$TMP_NAME/.$base"
        if [ -e "$dotpath" ]; then
          echo "Advertencia: no se dotificará $base porque .$base ya existe en el módulo $BASENAME" >&2
          continue
        fi
        # Renombrar (mover) la entrada a su nombre con prefijo '.'
        mv "$ent" "$dotpath" || true
      done
    fi

    # Eliminar cualquier directorio vacío dejado por exclusiones para evitar crear carpetas vacías con puntos
    find "$TMP_MOD_DIR/$TMP_NAME" -type d -empty -delete || true

    echo "Aplicando módulo $BASENAME (desde copia saneada)"
    # Ejecutar la instalación solo si la copia temporal del módulo contiene archivos tras aplicar las exclusiones
    if (cd "$TMP_MOD_DIR" && find "$TMP_NAME" -mindepth 1 -print -quit | grep -q .); then
      # Crear manualmente enlaces simbólicos para evitar dejar archivos sin punto en $HOME
      echo "Creando enlaces simbólicos para archivos en $TMP_NAME"
      while IFS= read -r -d $'\0' tmpf; do
        # eliminar el prefijo './' producido por find y omitir la raíz './'
        rel=${tmpf#./}
        [ "$rel" = "." ] && continue
        # mapear al destino usando el auxiliar/función existente
        map_target "$rel" "$BASENAME"
        DEST="$MAP_TARGET_OUT"
        if [[ "$DEST" == "__IGNORE__" ]]; then
          continue
        fi
        # Si es un mapeo explícito, ya se manejó anteriormente
        if [ "${MAP_TARGET_EXPLICIT:-0}" -eq 1 ]; then
          continue
        fi
        # Resolver la fuente en el repositorio. Si una entrada dotificada a nivel superior existe solo en tmp,
        # intentar el nombre sin punto en el origen (i.e., 'name' -> '.name' fue dotificado en tmp)
        repo_rel="$rel"
        if [[ "$repo_rel" == .* ]]; then
          # para nombres dotificados a nivel superior de la forma '.foo' => intentar 'foo'
          # solo alterar el primer segmento de la ruta
          rest="${repo_rel#./}" || true
          non_dot="${repo_rel#.}"
          if [ -e "$MOD/$non_dot" ]; then
            repo_rel="$non_dot"
          fi
        fi
        SRC_ABS="$(cd "$(dirname "$MOD")" && printf '%s/%s' "$(pwd -P)" "$repo_rel")"
        # Omitir directorios (crearemos los directorios padres por separado)
        if [ -d "$TMP_MOD_DIR/$TMP_NAME/$rel" ]; then
          mkdir -p "$DEST" || true
          continue
        fi
        # Si el destino existe y ya es el enlace simbólico correcto, omitir
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
        # Algunos archivos de inicio interactivo pueden tener CRLF; reutilizar la lógica de saneamiento
        SANITIZE_BASENAMES=('.bashrc' '.profile' '.bash_profile' '.zshrc' '.bash_logout')
        base_name="$(basename -- "$rel")"
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
        if [ -n "${_ALREADY_MAPPED[$DEST]:-}" ]; then
          echo "Omitiendo mapeo (duplicado): $DEST ya fue mapeado"
          continue
        fi
        # Si el mapeo fue múltiple (coma-separado), crear un enlace por cada especificación
        MAP_KEY_TMP2="${MAP_TARGET_KEY:-}"
        if [[ "$MAP_KEY_TMP2" == *,* ]]; then
          specs="${MAP_KEY_TMP2}"
          specs="${specs#__MULTI__:}"
          IFS=',' read -ra SPEC_TMP <<< "$specs"
          for spec in "${SPEC_TMP[@]}"; do
            spec_trimmed="$(echo "$spec" | sed -e 's/^\s*//' -e 's/\s*$//')"
            destp="$(mapping_spec_to_path "$spec_trimmed" "$BASENAME")"
            echo "Creando enlace simbólico: $destp -> $sanitized_src"
            ln -sfn "$sanitized_src" "$destp" || true
          done
        else
          echo "Creando enlace simbólico: $DEST -> $sanitized_src"
          ln -sfn "$sanitized_src" "$DEST" || true
        fi
        _ALREADY_MAPPED[$DEST]=1
      done < <(cd "$TMP_MOD_DIR/$TMP_NAME" && find . -mindepth 1 -print0)
    else
      echo "Omitiendo módulo (nada que instalar tras las exclusiones): $BASENAME"
    fi
    # Crear enlaces simbólicos con prefijo '.' para los nombres identificados en DOTIFY_BASENAMES
    if [[ ${#DOTIFY_BASENAMES[@]} -gt 0 ]]; then
      for base in "${DOTIFY_BASENAMES[@]}"; do
        SRC_ABS="$(cd "$(dirname "$MOD")" && printf '%s/%s' "$(pwd -P)" "$base")"
        DEST="$TARGET/.${base}"
        # Omitir si el enlace simbólico ya es correcto
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
    # verificar que los destinos de mapeo explícitos sean enlaces simbólicos; si no, hacer respaldo y recrearlos
    for d in "${map_created[@]:-}"; do
      [ -z "$d" ] && continue
      if [ ! -L "$d" ]; then
        echo "Post-instalación: no se encontró un enlace simbólico en la ruta de mapeo $d — será respaldado y se recreará el enlace simbólico"
        if [ -e "$d" ]; then
          BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%s)/$BASENAME"
          mkdir -p "$(dirname "$BACKUP_DIR/${d#"${TARGET}/"}")" || true
          mv "$d" "$BACKUP_DIR/${d#"${TARGET}/"}" || true
        fi
        # intentar recrear el enlace simbólico (buscar el origen por nombre de archivo dentro del módulo)
        fname="$(basename -- "$d")"
        found_src=$(cd "$(dirname -- "$MOD")" && find "$(basename -- "$MOD")" -type f -name "$fname" -print -quit || true)
        if [ -n "$found_src" ]; then
          SRC_ABS="$(cd "$(dirname "$MOD")" && printf '%s/%s' "$(pwd -P)" "$found_src")"
          # mismo comportamiento de saneamiento que más arriba: si la fuente es uno de los archivos
          # de inicio interactivo y contiene CRLF, escribir una copia saneada bajo $TARGET/.dotfiles_sanitized
          # y enlazarla.
          SANITED_SRC_TO_LINK="$SRC_ABS"
          for _s in "${SANITIZE_BASENAMES[@]:-.bashrc .profile .bash_profile .zshrc .bash_logout}"; do
            if [[ "${_s}" == "$(basename -- "$found_src")" ]]; then
              if grep -q $'\r' "$SRC_ABS" 2>/dev/null || head -c 1 -q "$SRC_ABS" | od -An -t x1 | grep -q '0d'; then
                SAN_DIR="$TARGET/.dotfiles_sanitized/$BASENAME/$(dirname "$found_src")"
                mkdir -p "$SAN_DIR" || true
                SAN_PATH="$SAN_DIR/$(basename -- "$found_src")"
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
    # limpieza
    rm -rf "$TMP_MOD_DIR"

  else
    echo "Advertencia: módulo $MOD no existe"
  fi
done

echo "Instalación finalizada. Este instalador solo aplica dotfiles de usuario en \\${HOME}."
echo "Si necesitas aplicar cambios a nivel sistema (Xorg, etc.), hazlo manualmente con permisos de root."
echo "Recuerda revisar los archivos instalados para asegurarte de que todo esté como deseas."

# Configurar automáticamente los hooks de git (si están disponibles) — es seguro, idempotente y solo afecta la configuración local de git
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  REPO_ROOT=$(git rev-parse --show-toplevel)
  SETUP_SCRIPT="$REPO_ROOT/scripts/setup-githooks.sh"
  if [ -f "$SETUP_SCRIPT" ]; then
    echo "Configurando hooks de git localmente (core.hooksPath -> .githooks)"
    # ejecutar script de configuración, omitir errores (no fatales)
    "$SETUP_SCRIPT" || true
  fi
fi
