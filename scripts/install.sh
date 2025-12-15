#!/usr/bin/env bash
# Instalador mínimo para dotfiles del usuario (guiado por mapeos, sin herramienta externa para symlinks)

set -euo pipefail

# Archivos de texto que son candidatos para el saneamiento de finales de línea (CRLF -> LF).
readonly SANITIZE_BASENAMES=(".bashrc" ".profile" ".bash_profile" ".zshrc" ".bash_logout")

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
# ToDo: agregar opcion "help" sin lineas al estilo systemd
  usage
  exit 0
fi

#
# readlink_canonical
#
# Resuelve la ruta canónica de un archivo o enlace simbólico de forma compatible
# con sistemas que no tienen readlink -f (BSD, macOS, algunos Gentoo).
#
# Uso:
#   resolved_path=$(readlink_canonical "ruta/al/archivo")
#
# Parámetros:
#   $1: path - Ruta al archivo o enlace simbólico a resolver
#
# Salida:
#   Imprime la ruta canónica resuelta, o la ruta original si no se puede resolver
#
readlink_canonical() {
  local target_path="$1"
  
  # Si la ruta está vacía, devolverla tal cual
  if [ -z "$target_path" ]; then
    printf '%s' "$target_path"
    return 0
  fi
  
  # Intentar usar readlink -f si está disponible (GNU/Linux)
  if command -v readlink >/dev/null 2>&1; then
    # Probar si readlink soporta -f usando un archivo que sabemos que existe
    # Usar /dev/null que existe en todos los sistemas Unix
    if readlink -f /dev/null >/dev/null 2>&1; then
      local resolved
      resolved=$(readlink -f "$target_path" 2>/dev/null)
      if [ -n "$resolved" ]; then
        printf '%s' "$resolved"
        return 0
      fi
    fi
  fi
  
  # Alternativa: usar cd y pwd -P para resolver la ruta canónica
  # Esto funciona en BSD, macOS y sistemas sin readlink -f
  # Primero, resolver enlaces simbólicos manualmente si es necesario
  local current_path="$target_path"
  local max_links=40  # Límite para evitar bucles infinitos
  local link_count=0
  
  # Seguir enlaces simbólicos hasta llegar al archivo real
  while [ -L "$current_path" ] && [ $link_count -lt $max_links ]; do
    local link_target
    link_target=$(readlink "$current_path" 2>/dev/null || echo "")
    if [ -z "$link_target" ]; then
      break
    fi
    # Si el enlace es relativo, resolverlo respecto al directorio del enlace
    if [ "${link_target#/}" = "$link_target" ]; then
      current_path="$(dirname -- "$current_path")/$link_target"
    else
      current_path="$link_target"
    fi
    # Normalizar la ruta (eliminar .. y .)
    current_path=$(cd "$(dirname -- "$current_path")" 2>/dev/null && printf '%s/%s' "$(pwd -P)" "$(basename -- "$current_path")" 2>/dev/null || echo "$current_path")
    link_count=$((link_count + 1))
  done
  
  # Ahora resolver la ruta canónica usando cd y pwd -P
  local dir_name file_name
  if [ -d "$current_path" ]; then
    # Es un directorio
    dir_name="$current_path"
    file_name=""
  else
    # Es un archivo, separar directorio y nombre
    dir_name="$(dirname -- "$current_path")"
    file_name="$(basename -- "$current_path")"
  fi
  
  # Resolver el directorio canónico
  local canonical_dir
  if [ -d "$dir_name" ]; then
    canonical_dir=$(cd "$dir_name" && pwd -P 2>/dev/null)
    if [ -z "$canonical_dir" ]; then
      # Fallback: usar la ruta original si cd falla
      printf '%s' "$target_path"
      return 0
    fi
  else
    # El directorio no existe, devolver la ruta original
    printf '%s' "$target_path"
    return 0
  fi
  
  # Si es un archivo, agregar el nombre del archivo
  if [ -n "$file_name" ]; then
    printf '%s/%s' "$canonical_dir" "$file_name"
  else
    printf '%s' "$canonical_dir"
  fi
}

#
# sanitize_crlf_if_needed
#
# Comprueba si un archivo de texto necesita saneamiento de finales de línea (CRLF -> LF)
# y, de ser así, crea una copia saneada en un directorio temporal bajo $TARGET.
# Esto es importante para scripts de shell (.bashrc, .profile, etc.) que pueden
# fallar si tienen finales de línea de Windows.
#
# Uso:
#   local source_to_link
#   source_to_link=$(sanitize_crlf_if_needed "ruta/al/origen" "ruta/relativa/origen" "nombre_del_modulo")
#
# Parámetros:
#   $1: src_abs_path  - Ruta absoluta al archivo fuente original en el repositorio.
#   $2: rel_path      - Ruta relativa del archivo dentro del módulo (para la estructura del directorio de saneado).
#   $3: module_name   - Nombre base del módulo actual (para la estructura del directorio de saneado).
#
# Salida:
#   Imprime la ruta al archivo que se debe enlazar. Será la ruta original si no se
#   necesitó saneamiento, o la ruta al nuevo archivo saneado si se realizó la conversión.
#
sanitize_crlf_if_needed() {
  local src_abs_path="$1"
  local rel_path="$2"
  local module_name="$3"
  
  local base_name
  base_name=$(basename -- "$rel_path")
  
  local needs_sanitization=0
  for s in "${SANITIZE_BASENAMES[@]}"; do
    if [[ "$s" == "$base_name" ]]; then
      # Detectar si el archivo contiene carácteres de retorno de carro (CR).
      # `grep -q` es más eficiente ya que se detiene en la primera coincidencia.
      if grep -q $'\r' "$src_abs_path"; then
        needs_sanitization=1
      fi
      break
    fi
  done

  if [[ $needs_sanitization -eq 1 ]]; then
    # Construir la ruta para el archivo saneado, p. ej., ~/.dotfiles_sanitized/bash/.bashrc
    local san_dir
    san_dir="$TARGET/.dotfiles_sanitized/$module_name/$(dirname "$rel_path")"
    mkdir -p "$san_dir"
    
    local san_path="$san_dir/$base_name"
    
    echo "Saneando CRLF -> LF para '$rel_path' en: $san_path"
    
    # Usar awk para eliminar el carácter de retorno de carro de cada línea.
    # Preservar el bit de ejecución si el archivo original lo tenía.
    if [ -x "$src_abs_path" ]; then
      awk '{ sub("\r$", ""); print }' "$src_abs_path" > "$san_path" && chmod +x "$san_path"
    else
      awk '{ sub("\r$", ""); print }' "$src_abs_path" > "$san_path"
    fi
    
    # Devolver la ruta al nuevo archivo saneado.
    printf '%s' "$san_path"
  else
    # No se necesita saneamiento, devolver la ruta original.
    printf '%s' "$src_abs_path"
  fi
}

_create_symlink_and_backup_if_needed() {
  local src_abs_path="$1"
  local dest_path="$2"
  local module_name="$3"
  local relative_path_for_backup="$4"
  local check_already_mapped="$5" # 1 para sí, 0 para no

  # Usar helper para verificar symlink existente
  if _is_correct_symlink "$dest_path" "$src_abs_path"; then
    echo "Omitiendo enlace simbólico ya existente: $dest_path"
    return 0
  fi

  # Respaldar si existe y no es un enlace simbólico (usar helper)
  if [ -e "$dest_path" ] && [ ! -L "$dest_path" ]; then
    _create_backup "$dest_path" "$module_name" "$relative_path_for_backup"
  fi

  mkdir -p "$(dirname "$dest_path")"
  echo "Creando enlace simbólico: $dest_path -> $src_abs_path"
  ln -sfn "$src_abs_path" "$dest_path"

  if [ "$check_already_mapped" -eq 1 ]; then
    _ALREADY_MAPPED[$dest_path]=1
  fi
  return 0
}

# ===== FUNCIONES HELPER PARA REDUCIR DUPLICACIÓN =====

# Función auxiliar para generar timestamp único para backups
_get_backup_timestamp() {
  # Intentar nanosegundos primero, fallback a segundos con PID para unicidad
  if date +%s%N >/dev/null 2>&1; then
    date +%s%N
  else
    echo "$(date +%s)_$$"
  fi
}

# Función auxiliar para resolver ruta absoluta dentro de un módulo
_module_absolute_path() {
  local module_dir="$1"
  local relative_path="$2"
  (cd "$module_dir" && printf '%s/%s' "$(pwd -P)" "$relative_path")
}

# Función auxiliar para eliminar espacios al inicio y final de una cadena
_trim() {
  local str="$1"
  str="${str#"${str%%[![:space:]]*}"}"
  str="${str%"${str##*[![:space:]]}${str##*[![:space:]]}"}"
  printf '%s' "$str"
}

# Función auxiliar para verificar si un symlink ya apunta al destino correcto
_is_correct_symlink() {
  local link_path="$1"
  local expected_target="$2"
  
  [ -L "$link_path" ] || return 1
  
  local link_resolved target_resolved
  link_resolved=$(readlink_canonical "$link_path")
  target_resolved=$(readlink_canonical "$expected_target")
  
  [ "$link_resolved" = "$target_resolved" ]
}

# Función auxiliar para crear backup de un archivo
_create_backup() {
  local file_path="$1"
  local module_name="$2"
  local relative_path="$3"
  
  # PROTECCIÓN CRÍTICA: Nunca permitir backup de HOME o raíz
  if [ "$file_path" = "$HOME" ] || [ "$file_path" = "/" ]; then
    echo "ERROR CRÍTICO: Intento de respaldar directorio del sistema: $file_path" >&2
    echo "Abortando para prevenir pérdida de datos" >&2
    exit 99
  fi
  
  # PROTECCIÓN CRÍTICA: Solo permitir backup de archivos, NO directorios
  if [ -d "$file_path" ]; then
    echo "ERROR CRÍTICO: Intento de respaldar directorio completo: $file_path" >&2
    echo "Esta función solo debe usarse para archivos individuales" >&2
    echo "Si esto ocurre, es un bug que debe reportarse" >&2
    exit 99
  fi
  
  local backup_dir
  backup_dir="$HOME/.dotfiles_backup/$(_get_backup_timestamp)/$module_name"
  local backup_path="$backup_dir/$relative_path"
  
  mkdir -p "$(dirname "$backup_path")"
  echo "Respaldando $file_path a $backup_path"
  mv "$file_path" "$backup_path"
}

# Función para instalar un módulo individual
install_module() {
  local MOD="$1"
  declare -A _ALREADY_MAPPED=()
  if [ -d "$MOD" ]; then
    local BASENAME; BASENAME=$(basename -- "$MOD")
    echo "Preparando instalación: $BASENAME -> $TARGET"

    # Precaución: omitir módulos que contengan rutas a nivel de sistema (p. ej., etc/) porque este instalador
    # opera únicamente sobre archivos a nivel de usuario bajo $HOME. Si quieres aplicar archivos de sistema,
    # hazlo manualmente (o ejecuta un instalador a nivel de sistema como root).
    if (cd "$(dirname "$MOD")" && find "$(basename -- "$MOD")" -mindepth 1 -maxdepth 2 -type f -path '*/etc/*' | read -r); then
      echo "Omitiendo módulo $BASENAME porque contiene archivos a nivel de sistema bajo 'etc/'." >&2
      echo "Este instalador no aplicará archivos destinados a /etc (p. ej., /etc/thinkfan.conf)." >&2
      return
    fi

    # Verificación en seco: listar destinos en conflicto (considerar mapeos XDG)
    local CONFLICTS=()
    while IFS= read -r -d $'\0' SRC; do
      # calcular REL relativo a la raíz del módulo (eliminar prefijo de la carpeta del módulo)
      local REL=${SRC#"${BASENAME}"/}
      map_target "$REL" "$BASENAME"
      local TARGET_PATH="$MAP_TARGET_OUT"
      if [ -e "$TARGET_PATH" ] || [ -L "$TARGET_PATH" ]; then
        # si es un enlace simbólico que apunta al mismo destino, omitir
        if [ -L "$TARGET_PATH" ]; then
          local target_resolved mod_rel_resolved
          target_resolved=$(readlink_canonical "$TARGET_PATH")
          mod_rel_resolved=$(readlink_canonical "$MOD/$REL")
          if [ "$target_resolved" = "$mod_rel_resolved" ]; then
            continue
          fi
        fi
        CONFLICTS+=("$TARGET_PATH")
      fi
    done < <(cd "$(dirname "$MOD")" && find "$(basename -- "$MOD")" -mindepth 1 -print0)

    if [ ${#CONFLICTS[@]} -gt 0 ]; then
      echo "Conflictos detectados al aplicar módulo $BASENAME:" >&2
      for c in "${CONFLICTS[@]}"; do echo "  - $c" >&2; done
      local BACKUP_DIR
      BACKUP_DIR="$HOME/.dotfiles_backup/$(_get_backup_timestamp)/$BASENAME"
      echo "Respaldando archivos conflictivos a: $BACKUP_DIR"
      for c in "${CONFLICTS[@]}"; do
        local RELPATH="${c#"$HOME"/}"
        mkdir -p "$(dirname "$BACKUP_DIR/$RELPATH")"
        mv "$c" "$BACKUP_DIR/$RELPATH"
      done
    fi

    # Detectar ficheros mapeados en cualquier parte del módulo (no solo en la raíz) y
    # crear los enlaces simbólicos XDG/~/HOME correctos. Luego excluirlos de la copia
    # temporal del módulo.
    # Crear un módulo temporal saneado para la instalación (excluir ficheros mapeados en raíz y cualquier entrada etc/)
    local TMP_MOD_DIR; TMP_MOD_DIR="$(mktemp -d)"
    local TMP_NAME="${BASENAME}.tmp"
    mkdir -p "$TMP_MOD_DIR/$TMP_NAME"
    # Copiar el contenido del módulo pero excluir los ficheros a nivel raíz que se mapean
    # a otras ubicaciones y excluir también la carpeta etc/
    # Construir la lista de exclusión para archivos situada en la raíz del módulo que estén mapeados
    # (los manejaremos con enlaces simbólicos explícitos) — además excluir etc/
    local EXCLUDE_ARGS=(--exclude '/etc/')
    # Excluir solo ficheros mapeados coincidentes; soportar rutas relativas exactas y nombres base.
    for rel in "${!_MAPPED_RELS[@]}"; do
      # si este es un mapeo específico por módulo (formato 'rel|module'), dividirlo y asegurar que coincida con el módulo
      if [[ "$rel" == *"|"* ]]; then
        local rel_key="${rel%%|*}"
        local rel_mod="${rel##*|}"
        if [[ "$rel_mod" != "$BASENAME" ]]; then
          continue
        fi
        EXCLUDE_ARGS+=(--exclude "/${rel_key}")
      else
        EXCLUDE_ARGS+=(--exclude "/${rel}")
      fi
    done
    for mapped in "${!_MAPPED_NAMES[@]}"; do
      # SOLO excluir si NO existe un mapeo específico por módulo para este archivo en el módulo actual
      # Si existe un mapeo "archivo|módulo" donde módulo == BASENAME, NO excluir
      local has_module_specific_mapping=0
      # Verificar si existe mapeo "$mapped|$BASENAME" en _MAPPER_MODULE
      if [[ -n "${_MAPPER_MODULE[$mapped|$BASENAME]:-}" ]]; then
        has_module_specific_mapping=1
      fi
      
      # Solo excluir si no hay mapeo específico para este módulo
      if [[ $has_module_specific_mapping -eq 0 ]]; then
        # excluir cualquier ocurrencia del nombre base mapeado en cualquier parte del árbol del módulo
        EXCLUDE_ARGS+=(--exclude "**/${mapped}")
        # excluir también cualquier ocurrencia a nivel superior
        EXCLUDE_ARGS+=(--exclude "/${mapped}")
      fi
    done
    # Si DEFAULT_ACTION es 'dotify', identificar entradas top-level que deberíamos dotificar
    local DOTIFY_BASENAMES=()
    if [[ "$DEFAULT_ACTION" == "dotify" ]]; then
      while IFS= read -r -d $'\0' top; do
        local base
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
      # Si rsync no está disponible, copiar todo y luego eliminar los archivos excluidos manualmente
      (cd "$(dirname "$MOD")" && cp -a "$(basename -- "$MOD")/" "$TMP_MOD_DIR/$TMP_NAME/" )
      # Eliminar archivos y directorios excluidos del módulo temporal
      for exclude_pattern in "${EXCLUDE_ARGS[@]}"; do
        # rsync usa --exclude, pero aquí necesitamos usar find para eliminar
        # Convertir patrón de exclusión de rsync a patrón de find
        local pattern="${exclude_pattern#--exclude }"
        # Eliminar barras iniciales y ajustar patrón
        pattern="${pattern#/}"
        if [[ "$pattern" == **/* ]]; then
          # Patrón recursivo: eliminar todas las ocurrencias
          find "$TMP_MOD_DIR/$TMP_NAME" -path "*/${pattern#**/}" -delete 2>/dev/null || true
        else
          # Patrón simple: eliminar en raíz
          # SC2115: Proteger contra expansión a / usando ${var:?}
          local target_path="${TMP_MOD_DIR:?}/$TMP_NAME/${pattern#/}"
          if [ -n "$target_path" ] && [ "$target_path" != "/" ]; then
            rm -rf "$target_path" 2>/dev/null || true
          fi
        fi
      done
    fi

    # Manejar ficheros mapeados encontrados en cualquier parte del módulo (crear enlaces simbólicos XDG apropiados)
    # Intentaremos coincidir primero con mapeos por módulo, y luego volver al mapeo global
    # Para mapeos por nombre base, buscar una única coincidencia dentro del módulo
    local map_created=()
    while IFS= read -r -d $'\0' found; do
      # calcular ruta relativa desde la carpeta del módulo
      local found_rel
      found_rel=${found#"$(basename -- "$MOD")/"}
      local fbase
      fbase=$(basename -- "$found_rel")
      map_target "$found_rel" "$BASENAME"
      local DEST="$MAP_TARGET_OUT"
      local MAP_TARGET_EXPLICIT_TMP=${MAP_TARGET_EXPLICIT:-0}
      local MAP_TARGET_KEY_TMP=${MAP_TARGET_KEY:-}
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
        local count
        count=$(cd "$(dirname -- "$MOD")" && find "$(basename -- "$MOD")" -type f -name "$fbase" | wc -l)
        if [ "$count" -gt 1 ]; then
          echo "Mapeo ambiguo: existen varios archivos llamados $fbase en el módulo $BASENAME; usa un mapeo por ruta relativa en install-mappings.yml para desambiguar." >&2
          continue
        fi
      fi
      # Siempre crear enlace simbólico para mapeos explícitos (incluso si la ruta coincide con la predeterminada); esto asegura
      # que los archivos se instalen en destinos XDG/explicados aunque estén excluidos de la copia temporal del módulo.
      # los archivos se instalan en destinos XDG/explicados incluso cuando están excluidos de la copia temporal del módulo.
      if [ "${MAP_TARGET_EXPLICIT_TMP:-1}" -eq 1 ]; then
        # Soporte para mapeos múltiples separados por comas
        if [[ "${MAP_TARGET_KEY_TMP:-}" == *,* ]]; then
          local specs="${MAP_TARGET_KEY_TMP#__MULTI__:}"  # Consolidar asignación duplicada
          IFS=',' read -ra SPEC_ARR <<< "$specs"
          for spec in "${SPEC_ARR[@]}"; do
            local spec_trimmed
            spec_trimmed="$(_trim "$spec")"  # Usar helper _trim
            local DEST_PATH
            DEST_PATH="$(mapping_spec_to_path "$spec_trimmed" "$BASENAME")"
            local SRC_ABS
            SRC_ABS="$(_module_absolute_path "$MOD" "$found_rel")"  # Usar helper
            local sanitized_src
            sanitized_src=$(sanitize_crlf_if_needed "$SRC_ABS" "$found_rel" "$BASENAME")
            _create_symlink_and_backup_if_needed "$sanitized_src" "$DEST_PATH" "$BASENAME" "$found_rel" 0
            map_created+=("$DEST_PATH")
          done
        else
          local SRC_ABS
          SRC_ABS="$(_module_absolute_path "$MOD" "$found_rel")"  # Usar helper
          
          # Usar helper para verificar symlink existente
          if _is_correct_symlink "$DEST" "$SRC_ABS"; then
            echo "Omitiendo enlace simbólico ya existente: $DEST"
          else
            local sanitized_src
            sanitized_src=$(sanitize_crlf_if_needed "$SRC_ABS" "$found_rel" "$BASENAME")
            _create_symlink_and_backup_if_needed "$sanitized_src" "$DEST" "$BASENAME" "$found_rel" 0
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
        local base
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
        local dotpath="$TMP_MOD_DIR/$TMP_NAME/.$base"
        if [ -e "$dotpath" ]; then
          echo "Advertencia: no se dotificará $base porque .$base ya existe en el módulo $BASENAME" >&2
          continue
        fi
        # Renombrar (mover) la entrada a su nombre con prefijo '.'
        mv "$ent" "$dotpath"
      done
    fi

    # Eliminar cualquier directorio vacío dejado por exclusiones para evitar crear carpetas vacías con puntos
    # PROTECCIÓN: Verificar que el directorio existe antes de ejecutar find
    if [ -d "$TMP_MOD_DIR/$TMP_NAME" ]; then
      find "$TMP_MOD_DIR/$TMP_NAME" -mindepth 1 -type d -empty -delete
    else
      echo "Advertencia: Directorio temporal no encontrado, omitiendo limpieza: $TMP_MOD_DIR/$TMP_NAME" >&2
    fi

    echo "Aplicando módulo $BASENAME (desde copia saneada)"
    # Ejecutar la instalación solo si la copia temporal del módulo contiene archivos tras aplicar las exclusiones
    if (cd "$TMP_MOD_DIR" && find "$TMP_NAME" -mindepth 1 -print -quit | grep -q .); then
      # Crear manualmente enlaces simbólicos para evitar dejar archivos sin punto en $HOME
      echo "Creando enlaces simbólicos para archivos en $TMP_NAME"
      while IFS= read -r -d $'\0' tmpf; do
        # eliminar el prefijo './' producido por find y omitir la raíz './'
        local rel=${tmpf#./}
        [ "$rel" = "." ] && continue
        # mapear al destino usando el auxiliar/función existente
        map_target "$rel" "$BASENAME"
        local DEST="$MAP_TARGET_OUT"
        if [[ "$DEST" == "__IGNORE__" ]]; then
          continue
        fi
        # Si es un mapeo explícito, ya se manejó anteriormente
        if [ "${MAP_TARGET_EXPLICIT:-0}" -eq 1 ]; then
          continue
        fi
        # Resolver la fuente en el repositorio. Si una entrada dotificada a nivel superior existe solo en tmp,
        # intentar el nombre sin punto en el origen (i.e., 'name' -> '.name' fue dotificado in tmp)
        local repo_rel="$rel"
        if [[ "$repo_rel" == .* ]]; then
          # para nombres dotificados a nivel superior de la forma '.foo' => intentar 'foo'
          # solo alterar el primer segmento de la ruta
          local non_dot="${repo_rel#.}"
          if [ -e "$MOD/$non_dot" ]; then
            repo_rel="$non_dot"
          fi
        fi
        local SRC_ABS
        SRC_ABS="$(_module_absolute_path "$MOD" "$repo_rel")"  # Usar helper
        # Omitir directorios (crearemos los directorios padres por separado)
        if [ -d "$TMP_MOD_DIR/$TMP_NAME/$rel" ]; then
          mkdir -p "$DEST"
          continue
        fi
        # Usar helper para verificar symlink existente
        if _is_correct_symlink "$DEST" "$SRC_ABS"; then
          continue
        fi
        # Respaldar destinos existentes que no sean enlaces simbólicos (usar helper)
        if [ -e "$DEST" ] && [ ! -L "$DEST" ]; then
          _create_backup "$DEST" "$BASENAME" "$rel"
        fi
        # Crear directorio padre para el symlink
        local dest_dir
        dest_dir="$(dirname "$DEST")"
        mkdir -p "$dest_dir"
        
        # Validar que se creó correctamente
        if [ ! -d "$dest_dir" ]; then
          echo "ERROR: No se pudo crear directorio: $dest_dir" >&2
          echo "Verifica permisos y espacio en disco" >&2
          continue
        fi
        
        # Algunos archivos de inicio interactivo pueden tener CRLF; reutilizar la lógica de saneamiento
        local sanitized_src
        sanitized_src=$(sanitize_crlf_if_needed "$SRC_ABS" "$rel" "$BASENAME")
        if [ -n "${_ALREADY_MAPPED[$DEST]:-}" ]; then
          echo "Omitiendo mapeo (duplicado): $DEST ya fue mapeado"
          continue
        fi
        # Si el mapeo fue múltiple (coma-separado), crear un enlace por cada especificación
        local MAP_KEY_TMP2="${MAP_TARGET_KEY:-}"
        if [[ "$MAP_KEY_TMP2" == *,* ]]; then
          local specs="${MAP_KEY_TMP2}"
          local specs="${specs#__MULTI__:}"
          IFS=',' read -ra SPEC_TMP <<< "$specs"
          for spec in "${SPEC_TMP[@]}"; do
            local spec_trimmed
            spec_trimmed="$(_trim "$spec")"  # Usar helper _trim
            local destp
            destp="$(mapping_spec_to_path "$spec_trimmed" "$BASENAME")"
            _create_symlink_and_backup_if_needed "$sanitized_src" "$destp" "$BASENAME" "$rel" 1
          done
        else
          _create_symlink_and_backup_if_needed "$sanitized_src" "$DEST" "$BASENAME" "$rel" 1
        fi
      done < <(cd "$TMP_MOD_DIR/$TMP_NAME" && find . -mindepth 1 -print0)
    else
      echo "Omitiendo módulo (nada que instalar tras las exclusiones): $BASENAME"
    fi
    # Crear enlaces simbólicos con prefijo '.' para los nombres identificados en DOTIFY_BASENAMES
    if [[ ${#DOTIFY_BASENAMES[@]} -gt 0 ]]; then
      for base in "${DOTIFY_BASENAMES[@]}"; do
        local SRC_ABS
        SRC_ABS="$(_module_absolute_path "$MOD" "$base")"  # Usar helper
        local DEST="$TARGET/.${base}"
        _create_symlink_and_backup_if_needed "$SRC_ABS" "$DEST" "$BASENAME" "$base" 0
        echo "Creado enlace dotificado: $DEST -> $SRC_ABS"
      done
    fi
    # verificar que los destinos de mapeo explícitos sean enlaces simbólicos; si no, hacer respaldo y recrearlos
    for d in "${map_created[@]:-}"; do
      [ -z "$d" ] && continue
      if [ ! -L "$d" ]; then
        echo "Post-instalación: no se encontró un enlace simbólico en la ruta de mapeo $d — será respaldado y se recreará el enlace simbólico"
        if [ -e "$d" ]; then
          _create_backup "$d" "$BASENAME" "${d#"${TARGET}/"}"  # Usar helper
        fi
        # intentar recrear el enlace simbólico (buscar el origen por nombre de archivo dentro del módulo)
        local fname
        fname="$(basename -- "$d")"
        local found_src
        found_src=$(cd "$MOD" && find . -type f -name "$fname" -print -quit)
        if [ -n "$found_src" ]; then
          found_src="${found_src#./}"
          local SRC_ABS
          SRC_ABS="$(_module_absolute_path "$MOD" "$found_src")"  # Usar helper
          local SANITED_SRC_TO_LINK
          SANITED_SRC_TO_LINK=$(sanitize_crlf_if_needed "$SRC_ABS" "$found_src" "$BASENAME")
          ln -sfn "$SANITED_SRC_TO_LINK" "$d"
        fi
      fi
    done
    # limpieza
    rm -rf "$TMP_MOD_DIR"

  else
    echo "Advertencia: módulo $MOD no existe"
  fi
}

# Módulos predeterminados: reflejan la estructura de modules/ (excluye carpetas a nivel sistema como "system")
MODULES=(
  "modules/browsers/brave"
  "modules/browsers/chrome"
  "modules/browsers/firefox"
  "modules/cli-tools/bat"
  "modules/cli-tools/dust"
  "modules/cli-tools/eza"
  "modules/cli-tools/fd"
  "modules/cli-tools/fzf"
  "modules/cli-tools/htop"
  "modules/cli-tools/ripgrep"
  "modules/cli-tools/tmux"
  "modules/cli-tools/xmms"
  "modules/desktop/wm/fvwm"
  "modules/desktop/wm/hyprland"
  "modules/desktop/wm/icewm"
  "modules/desktop/wm/openbox"
  "modules/desktop/wm/sway"
  "modules/desktop/wm/twm"
  "modules/desktop/wm/windowmaker"
  "modules/desktop/wm/wlmaker"
  "modules/desktop/wm/x11"
  "modules/dev-tools/cargo"
  "modules/dev-tools/gemini"
  "modules/dev-tools/git"
  "modules/dev-tools/lazygit"
  "modules/dev-tools/npm"
  "modules/dev-tools/python"
  "modules/dev-tools/ssh"
  "modules/editor/emacs"
  "modules/editor/gedit"
  "modules/editor/helix"
  "modules/editor/kakoune"
  "modules/editor/kate"
  "modules/editor/latex"
  "modules/editor/micro"
  "modules/editor/nano"
  "modules/editor/nvim"
  "modules/editor/sublime"
  "modules/editor/vim"
  "modules/editor/vscode"
  "modules/editor/xed"
  "modules/pacman"
  "modules/shell/bash"
  "modules/shell/common"
  "modules/shell/elvish"
  "modules/shell/fish"
  "modules/shell/ksh"
  "modules/shell/mksh"
  "modules/shell/nushell"
  "modules/shell/pwsh"
  "modules/shell/starship"
  "modules/shell/tcsh"
  "modules/shell/xonsh"
  "modules/shell/zsh"
  "modules/term/alacritty"
  "modules/term/foot"
  "modules/term/gnome-terminal"
  "modules/term/kitty"
  "modules/term/konsole"
  "modules/term/tilix"
  "modules/term/xfce4-terminal"
  "modules/term/xterm"
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
cd "$REPO_ROOT"

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

# Función para instalar git-lfs de forma segura
install_git_lfs_safely() {
  # 1. Comprobar si git-lfs ya está instalado
  if command -v git-lfs >/dev/null 2>&1; then
    echo "git-lfs ya está instalado."
    return 0
  fi

  echo "El comando 'git-lfs' no se encontró. Es necesario para inicializar algunos submódulos."

  # 2. Determinar el gestor de paquetes y el comando de instalación
  local pkg_manager=""
  local install_cmd=""
  local needs_sudo=1 # La mayoría necesita sudo por defecto

  if command -v apt >/dev/null 2>&1; then
    pkg_manager="apt"
    install_cmd="sudo apt update && sudo apt install -y git-lfs"
  elif command -v pacman >/dev/null 2>&1; then
    pkg_manager="pacman"
    install_cmd="sudo pacman -Syu --noconfirm --needed git-lfs"
  elif command -v dnf >/dev/null 2>&1; then
    pkg_manager="dnf"
    install_cmd="sudo dnf install -y git-lfs"
  elif command -v zypper >/dev/null 2>&1; then
    pkg_manager="zypper"
    install_cmd="sudo zypper install -y git-lfs"
  elif command -v emerge >/dev/null 2>&1; then
    pkg_manager="emerge (Gentoo)"
    install_cmd="sudo emerge --ask=n --quiet-build dev-vcs/git-lfs"
  elif command -v apk >/dev/null 2>&1; then
    pkg_manager="apk (Alpine)"
    install_cmd="sudo apk add git-lfs"
  elif command -v pkg >/dev/null 2>&1; then # Para FreeBSD
    pkg_manager="pkg (FreeBSD)"
    install_cmd="sudo pkg install -y git-lfs"
  elif command -v brew >/dev/null 2>&1; then # Para macOS Homebrew
    pkg_manager="brew (macOS)"
    install_cmd="brew install git-lfs"
    needs_sudo=0 # Homebrew no usa sudo
  elif command -v slackpkg >/dev/null 2>&1; then
    pkg_manager="slackpkg"
    install_cmd="sudo slackpkg update && sudo slackpkg install git-lfs"
  elif command -v sbopkg >/dev/null 2>&1; then
    pkg_manager="sbopkg"
    install_cmd="sudo sbopkg -i git-lfs"
  else
    echo "Advertencia: No se detectó un gestor de paquetes compatible para instalar 'git-lfs'." >&2
    echo "Por favor, instala 'git-lfs' manualmente." >&2
    return 1
  fi
  
  # 3. Comprobar si es un shell no interactivo. No preguntar si no está en un TTY.
  if [[ ! -t 1 ]]; then
      echo "Advertencia: Entorno no interactivo detectado. Omitiendo la instalación de 'git-lfs'." >&2
      echo "Por favor, instala 'git-lfs' manualmente." >&2
      return 1
  fi

  # 4. Si se necesita sudo, hacer las comprobaciones pertinentes
  if [[ $needs_sudo -eq 1 ]] && ! command -v sudo >/dev/null 2>&1; then
    echo "Advertencia: El comando 'sudo' no está disponible, pero es necesario para '$pkg_manager'. No se puede instalar 'git-lfs' automáticamente." >&2
    echo "Por favor, instala 'git-lfs' manualmente y vuelve a ejecutar el script." >&2
    return 1
  fi

  # 5. Pedir confirmación al usuario
  local prompt_msg="Con tu gestor de paquetes '$pkg_manager', ¿quieres intentar instalar 'git-lfs'?"
  if [[ $needs_sudo -eq 1 ]]; then
    prompt_msg+=" (se usará sudo)"
  fi
  read -p "$prompt_msg (s/n) " -n 1 -r
  echo

  if [[ $REPLY =~ ^[Ss]$ ]]; then
    echo "Ejecutando: $install_cmd"
    if sh -c "$install_cmd"; then
        echo "'git-lfs' instalado correctamente."
        return 0
    else
        echo "Error: La instalación de 'git-lfs' falló." >&2
        return 1
    fi
  else
    echo "Omitiendo la instalación de 'git-lfs'. Algunos assets pueden no estar disponibles." >&2
    return 1
  fi
}

echo "Verificando dependencia: git-lfs..."
# Ejecutar la instalación segura y advertir si falla, pero no salir del script principal.
if ! install_git_lfs_safely; then
    echo "Advertencia: 'git-lfs' no está disponible o la instalación fue omitida. Los assets gestionados por LFS pueden no cargarse." >&2
fi

if ! git lfs install; then
    echo "Advertencia: 'git lfs install' falló. La configuración local de LFS puede estar incompleta." >&2
fi

# --- INICIO DE CAMBIO ---
# Asegurarse de que los submódulos y Git LFS estén inicializados
echo "Inicializando submódulos y Git LFS (si aplica)..."
if git submodule update --init --recursive -f && git lfs pull; then
  echo "Submódulos y Git LFS inicializados correctamente."
else
  echo "Advertencia: Falló la inicialización de submódulos o Git LFS. Algunas características pueden no estar disponibles." >&2
fi
# --- FIN DE CAMBIO ---

TARGET="${TARGET:-$HOME}"
echo "Usando target: $TARGET"

# Definir variables XDG base globalmente para uso en funciones auxiliares
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$TARGET/.config}"
XDG_DATA_HOME="${XDG_DATA_HOME:-$TARGET/.local/share}"
XDG_STATE_HOME="${XDG_STATE_HOME:-$TARGET/.local/state}"
XDG_CACHE_HOME="${XDG_CACHE_HOME:-$TARGET/.cache}"

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
      echo "Advertencia: Línea no reconocida en $MAPPINGS_FILE (línea $((i+1))): '$line'" >&2
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
    _MAPPED_RELS["$name|${k##*|}"]="1"
  fi
done

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

# Helper: verificar si un patrón con wildcard coincide con un nombre de archivo
_match_pattern() {
  local pattern="$1"
  local filename="$2"
  
  # Convertir patrón de shell a regex básico
  # * -> .*
  # ? -> .
  local regex="${pattern//\*/.*}"
  regex="${regex//\?/.}"
  
  if [[ "$filename" =~ ^${regex}$ ]]; then
    return 0
  fi
  return 1
}

# Auxiliar: mapear ruta destino usando solo valores de install-mappings.yml y DEFAULT_ACTION
map_target(){
  local srcfile module_name base mapping
  srcfile="$1"; module_name="$2"
  
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
    # Intentar coincidencia con patrones wildcard globales
    for pattern in "${!_MAPPER_GLOBAL[@]}"; do
      if [[ "$pattern" == *"*"* ]] || [[ "$pattern" == *"?"* ]]; then
        if _match_pattern "$pattern" "$base"; then
          mapping="${_MAPPER_GLOBAL[$pattern]}"
          MAP_TARGET_EXPLICIT=1
          MAP_TARGET_KEY="pattern:$pattern"
          break
        fi
      fi
    done
    if [ -z "${mapping:-}" ]; then
      mapping=""
      MAP_TARGET_EXPLICIT=0
      MAP_TARGET_KEY=""
    fi
  fi
  # Restablecer auxiliares/variables de salida
  MAP_TARGET_OUT=""
  # MAP_TARGET_EXPLICIT y MAP_TARGET_KEY ya se establecieron arriba
  
  if [ -n "$mapping" ]; then
    # permitir valores centinela especiales en los mapeos como 'ignore' o 'skip'
    if [[ "$mapping" =~ ^(ignore|skip)$ ]]; then
      MAP_TARGET_OUT="__IGNORE__"
      return
    fi
    # soportar múltiples destinos separados por comas
    if [[ "$mapping" == *,* ]]; then
      MAP_TARGET_OUT="__MULTI__:${mapping}"
      MAP_TARGET_EXPLICIT=1
      MAP_TARGET_KEY="${mapping}"
      return
    fi
    # Reutilizar lógica de mapeo simple
    MAP_TARGET_OUT="$(mapping_spec_to_path "$mapping" "$module_name")"
    MAP_TARGET_EXPLICIT=1
    MAP_TARGET_KEY="${mapping}"
    return
  fi

  # No hay mapeo presente — respetar DEFAULT_ACTION
  case "$DEFAULT_ACTION" in
    dotify)
      if [[ "$base" == .* ]]; then MAP_TARGET_OUT="$TARGET/$base"; else MAP_TARGET_OUT="$TARGET/.${base}"; fi
      MAP_TARGET_EXPLICIT=0; MAP_TARGET_KEY="default:$base"
      ;;
    home) MAP_TARGET_OUT="$TARGET/$base"; MAP_TARGET_EXPLICIT=0; MAP_TARGET_KEY="default:$base" ;;
    error) MAP_TARGET_OUT="__ERROR__"; MAP_TARGET_EXPLICIT=0; MAP_TARGET_KEY="default:error" ;;
    *) if [[ "$base" == .* ]]; then MAP_TARGET_OUT="$TARGET/$base"; else MAP_TARGET_OUT="$TARGET/.${base}"; fi
       MAP_TARGET_EXPLICIT=0; MAP_TARGET_KEY="default:$base" ;;
  esac
}

# Función para realizar verificaciones previas al vuelo, incluyendo mapeos ambiguos.
preflight_checks() {
  echo "Realizando verificaciones previas al vuelo para mapeos ambiguos..."
  declare -A global_map_sources
  local has_ambiguities=0

  for MOD in "${MODULES[@]}"; do
    local MOD_NAME; MOD_NAME=$(basename -- "$MOD")
    # Omitir directorios inexistentes
    [ ! -d "$MOD" ] && continue

    while IFS= read -r -d $'\0' FILE_PATH; do
      local REL_PATH
      REL_PATH=${FILE_PATH#"$MOD/"}
      local BASE_NAME
      BASE_NAME=$(basename -- "$REL_PATH")

      # Verificar mapeo específico por módulo (anula el mapeo global)
      if [[ -n "${_MAPPER_MODULE["$REL_PATH|$MOD_NAME"]+x}" || -n "${_MAPPER_MODULE["$BASE_NAME|$MOD_NAME"]+x}" ]]; then
        continue # Este archivo está explícitamente mapeado para este módulo, no hay ambigüedad.
      fi

      # Verificar mapeo global por ruta relativa o nombre base
      local global_map_key=""
      if [[ -n "${_MAPPER_GLOBAL["$REL_PATH"]+x}" ]]; then
        global_map_key="$REL_PATH"
      elif [[ -n "${_MAPPER_GLOBAL["$BASE_NAME"]+x}" ]]; then
        global_map_key="$BASE_NAME"
      fi

      if [[ -n "$global_map_key" ]]; then
        # Está mapeado globalmente. Registrar el módulo de origen.
        global_map_sources["$global_map_key"]+="${MOD_NAME} "
      fi
    done < <(find "$MOD" -type f -print0 2>/dev/null)
  done

  # Ahora, analizar las fuentes recolectadas
  for key in "${!global_map_sources[@]}"; do
    # Recortar espacios en blanco y contar palabras
    # SC2001: Usar expansión de parámetros en lugar de sed
    local sources_str="${global_map_sources[$key]}"
    sources_str="${sources_str% }"  # Eliminar espacio final
    local sources_arr
    read -ra sources_arr <<< "$sources_str"
    
    if [[ ${#sources_arr[@]} -gt 1 ]]; then
      if [[ $has_ambiguities -eq 0 ]]; then
        echo "ERROR: Mapeos de archivos ambiguos detectados. Los siguientes archivos existen en múltiples módulos pero están regidos por una única regla de mapeo global." >&2
        echo "Esto conduciría a una instalación impredecible donde el último módulo instalado gana." >&2
        echo "Para resolver esto, crea un mapeo específico por módulo (ej., 'filename|module_name: ...') en install-mappings.yml para cada uno." >&2
        echo "" >&2
        has_ambiguities=1
      fi
      echo "  - Archivo/Clave: '$key'" >&2
      echo "    Encontrado en módulos: ${sources_arr[*]}" >&2
      echo "    Regido por regla global: '$key: ${_MAPPER_GLOBAL[$key]}'" >&2
      echo "" >&2
    fi
  done

  if [[ $has_ambiguities -eq 1 ]]; then
    exit 1
  fi

  echo "No se encontraron mapeos ambiguos. Procediendo con la instalación."
}

# Run pre-flight checks before starting installation
preflight_checks

for MOD in "${MODULES[@]}"; do
  install_module "$MOD"
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
    if ! "$SETUP_SCRIPT"; then
      echo "Advertencia: La configuración de los githooks falló." >&2
    fi
  fi
fi
