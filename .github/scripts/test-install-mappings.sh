#!/usr/bin/env bash
set -euo pipefail

# Prueba de integración: ejecutar `scripts/install.sh` con un TARGET temporal y verificar
# que cualquier archivo declarado en `install-mappings.yml` y presente en `modules/` se crea
# en la ruta mapeada como un enlace simbólico apuntando de vuelta al archivo fuente en el módulo.

ROOT=$(git rev-parse --show-toplevel 2>/dev/null || echo .)
MAP_FILE="$ROOT/install-mappings.yml"
INSTALL_SCRIPT="$ROOT/scripts/install.sh"
MODULES_DIR="$ROOT/modules"

if [ ! -x "$INSTALL_SCRIPT" ]; then
  echo "Instalador no encontrado o no ejecutable: $INSTALL_SCRIPT" >&2
  exit 1
fi
if [ ! -f "$MAP_FILE" ]; then
  echo "No se encontró el archivo de mapeos en: $MAP_FILE" >&2
  exit 1
fi

TMP=$(mktemp -d)
export TARGET="$TMP"
mkdir -p "$TARGET"

echo "Ejecutando instalador contra TARGET: $TARGET"
cd "$ROOT"
# Construir lista de módulos: buscar directorios (profundidad 1-3) que contengan archivos de configuración.
# Evitar subdirectorios de módulos ya identificados (ej. evitar modules/shell/fish/.config si modules/shell/fish ya es módulo).
MOD_LIST=()
while IFS= read -r d; do
  # Si el directorio es subdirectorio de uno ya añadido, saltar
  for m in "${MOD_LIST[@]}"; do
    if [[ "$d" == "$m"/* ]]; then continue 2; fi
  done

  # Si contiene archivos (excluyendo README/LICENSE), es un módulo
  if find "$d" -maxdepth 1 -type f -not -name 'README*' -not -name 'LICENSE*' -print -quit | grep -q .; then
    MOD_LIST+=("$d")
  fi
done < <(find modules -mindepth 1 -maxdepth 3 -type d | sort)

# Función auxiliar: is_template(file)
# Devuelve 0 (verdadero) si el archivo está vacío o parece una plantilla (solo líneas en blanco/comentario o JSON trivial "{}"/"[]").
is_template() {
  f="$1"
  # Los archivos vacíos se consideran plantillas
  if [ ! -s "$f" ]; then
    return 0
  fi
  # Para archivos JSON, tratar {} o [] como plantilla
  if [[ "${f,,}" == *.json ]]; then
    trimmed=$(tr -d '[:space:]' < "$f") || trimmed=""
    if [ "$trimmed" = "{}" ] || [ "$trimmed" = "[]" ]; then
      return 0
    fi
  fi
  # Las claves privadas se consideran secretos si no están vacías
  bn=$(basename -- "$f")
  if [[ "$bn" =~ ^id_(rsa|ed25519)$ ]] || [[ "$bn" =~ ^id_.*_priv$ ]]; then
    return 1
  fi
  # Si cada línea no vacía comienza con un marcador de comentario (#, //, ;), tratar como plantilla
  non_comment_count=$(grep -c -E -v '^[[:space:]]*($|#|//|;)' "$f" || true)
  if [ "$non_comment_count" -eq 0 ]; then
    return 0
  fi
  return 1
}

# Patrones a analizar: ficheros que con frecuencia contienen credenciales o secretos.
declare -a SECRET_PATTERNS=(".git-credentials" ".netrc" ".npmrc" ".docker/config.json" ".aws/credentials" ".ssh/id_rsa" ".ssh/id_ed25519")
secret_errors=0
for pat in "${SECRET_PATTERNS[@]}"; do
  if [[ "$pat" == */* ]]; then
    mapfile -t found < <(find "$MODULES_DIR" -type f -path "*/${pat}" -print || true)
  else
    mapfile -t found < <(find "$MODULES_DIR" -type f -name "$pat" -print || true)
  fi
  for f in "${found[@]:-}"; do
    # skip example/sample files
    if [[ "$f" == *.example ]] || [[ "$f" == *.sample ]]; then
      continue
    fi
    if is_template "$f"; then
      echo "OK: archivo de plantilla/ejemplo encontrado (permitido): $f"
      continue
    fi
    echo "ERROR: encontrado probable secreto en módulos del repositorio: $f" >&2
    secret_errors=$((secret_errors+1))
  done
done
if [ $secret_errors -gt 0 ]; then
  echo "Rechazando ejecutar pruebas de mapeo: se encontraron $secret_errors archivo(s) que parecen secretos en modules." >&2
  exit 4
fi

if [ ${#MOD_LIST[@]} -eq 0 ]; then
  echo "No se encontraron módulos en modules/ - nada que instalar" >&2
  exit 0
fi

# Ejecutar el instalador y capturar el código de salida
# NO usar || true aquí - queremos que falle si install.sh falla
echo "Instalando módulos: ${MOD_LIST[*]}"
if ! ./scripts/install.sh "${MOD_LIST[@]}"; then
  echo "ERROR: install.sh falló con código de salida $?" >&2
  exit 1
fi

# Dar un segundo al instalador para que termine y produzca symlinks si hace fork de procesos en background
sleep 1

# calcular rutas base XDG tal como lo hace el instalador
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$TARGET/.config}"
XDG_DATA_HOME="${XDG_DATA_HOME:-$TARGET/.local/share}"
XDG_STATE_HOME="${XDG_STATE_HOME:-$TARGET/.local/state}"
XDG_CACHE_HOME="${XDG_CACHE_HOME:-$TARGET/.cache}"

errors=0
# Leer mapeos: extraer solo las líneas que contienen ':' para obtener las claves (evitar líneas de listas YAML que empiezan con '-')
# Usamos awk para eliminar comentarios y espacios y quedarnos solo con claves antes de ':'
map_keys=$(awk '{ line=$0; sub(/\r$/,"",line); sub(/^[[:space:]]*/,"",line); sub(/#.*$/,"",line); if(line ~ /^-/) next; if(index(line,":")>0){ key=line; sub(/:.*/, "",key); sub(/[[:space:]]*$/,"",key); print key } }' "$MAP_FILE" | sed '/^[[:space:]]*$/d' | sort -u)

# Función para resolver canonical path (compatible con install.sh)
readlink_canonical() {
  local target_path="$1"
  
  if [ -z "$target_path" ]; then
    printf '%s' "$target_path"
    return 0
  fi
  
  if command -v readlink >/dev/null 2>&1; then
    if readlink -f /dev/null >/dev/null 2>&1; then
      local resolved
      resolved=$(readlink -f "$target_path" 2>/dev/null)
      if [ -n "$resolved" ]; then
        printf '%s' "$resolved"
        return 0
      fi
    fi
  fi
  
  local current_path="$target_path"
  local max_links=40
  local link_count=0
  
  while [ -L "$current_path" ] && [ $link_count -lt $max_links ]; do
    local link_target
    link_target=$(readlink "$current_path" 2>/dev/null || echo "")
    if [ -z "$link_target" ]; then
      break
    fi
    if [ "${link_target#/}" = "$link_target" ]; then
      current_path="$(dirname -- "$current_path")/$link_target"
    else
      current_path="$link_target"
    fi
    current_path=$(cd "$(dirname -- "$current_path")" 2>/dev/null && printf '%s/%s' "$(pwd -P)" "$(basename -- "$current_path")" 2>/dev/null || echo "$current_path")
    link_count=$((link_count + 1))
  done
  
  local dir_name file_name
  if [ -d "$current_path" ]; then
    dir_name="$current_path"
    file_name=""
  else
    dir_name="$(dirname -- "$current_path")"
    file_name="$(basename -- "$current_path")"
  fi
  
  local canonical_dir
  if [ -d "$dir_name" ]; then
    canonical_dir=$(cd "$dir_name" && pwd -P 2>/dev/null)
    if [ -z "$canonical_dir" ]; then
      printf '%s' "$target_path"
      return 0
    fi
  else
    printf '%s' "$target_path"
    return 0
  fi
  
  if [ -n "$file_name" ]; then
    printf '%s/%s' "$canonical_dir" "$file_name"
  else
    printf '%s' "$canonical_dir"
  fi
}

# Función para resolver una especificación de mapeo a ruta completa
resolve_mapping_spec() {
  local spec="$1"
  local path=""
  
  case "$spec" in
    xdg:*) path="$XDG_CONFIG_HOME/${spec#xdg:}" ;;
    xdg_state:*) path="$XDG_STATE_HOME/${spec#xdg_state:}" ;;
    xdg_data:*) path="$XDG_DATA_HOME/${spec#xdg_data:}" ;;
    xdg_cache:*) path="$XDG_CACHE_HOME/${spec#xdg_cache:}" ;;
    home:*) path="$TARGET/${spec#home:}" ;;
    *) path="$TARGET/$spec" ;;
  esac
  
  printf '%s' "$path"
}

# Función para verificar un symlink individual
verify_symlink() {
  local expected="$1"
  local src="$2"
  local mapping_key="$3"
  
  # Verificar existencia
  if [ ! -e "$expected" ]; then
    echo "ERROR: el destino esperado no existe para el mapeo '$mapping_key': $expected (origen: $src)" >&2
    return 1
  fi
  
  if [ ! -L "$expected" ]; then
    echo "ERROR: el destino esperado no es un enlace simbólico para el mapeo '$mapping_key': $expected (origen: $src)" >&2
    return 1
  fi
  
  # Verificar objetivo del enlace
  local targ srcf
  targ=$(readlink_canonical "$expected")
  srcf=$(readlink_canonical "$src")
  
  if [ "$targ" = "$srcf" ]; then
    echo "OK: $expected -> $src"
    return 0
  fi
  
  # Verificar si es copia saneada
  local SAN_PREFIX="$TARGET/.dotfiles_sanitized"
  if [[ "$targ" == "$SAN_PREFIX"* ]]; then
    if [ ! -f "$targ" ]; then
      echo "ERROR: no existe el archivo saneado esperado: $targ (origen: $src)" >&2
      return 1
    fi
    # Verificar que el archivo saneado no contiene CRLF
    if grep -q $'\r' "$targ" 2>/dev/null; then
      echo "ERROR: el archivo saneado aún contiene CRLF: $targ" >&2
      return 1
    fi
    echo "OK: $expected -> $targ (copia saneada de $src)"
    return 0
  fi
  
  echo "ERROR: discrepancia en el objetivo del enlace para el mapeo '$mapping_key'. Se esperaba <$srcf>, pero se encontró <$targ>. (dest: $expected)" >&2
  return 1
}

get_map_val(){
  # devuelve el valor de mapeo para una clave dada (puede devolver lista o único valor)
  local key="$1"
  local raw line val
  while IFS= read -r raw; do
    line="${raw%%#*}"
    line="${line%$'\r'}"
    line="${line#"${line%%[![:space:]]*}"}"
    line="${line%"${line##*[![:space:]]}"}"
    [ -z "$line" ] && continue
    if [[ "$line" == "$key:"* ]]; then
      val="${line#"${key}":}"
      val="${val#"${val%%[![:space:]]*}"}"
      printf '%s' "$val"
      return 0
    fi
  done < "$MAP_FILE"
  # fallback: buscar entradas específicas por módulo (ej. key|module: value)
  while IFS= read -r raw; do
    line="${raw%%#*}"
    line="${line%$'\r'}"
    line="${line#"${line%%[![:space:]]*}"}"
    line="${line%"${line##*[![:space:]]}"}"
    [ -z "$line" ] && continue
    if [[ "$line" == "$key|"* ]]; then
      val="${line#*":"}"
      val="${val#"${val%%[![:space:]]*}"}"
      printf '%s' "$val"
      return 0
    fi
  done < "$MAP_FILE"
  return 1
}

while IFS= read -r mapping_key; do
  [ -z "$mapping_key" ] && continue
  key="$mapping_key"
  val=""
  val=$(get_map_val "$key" || true)
  [ -z "$val" ] && continue
  # Si el mapeo es 'ignore' o 'skip', omitir
  if echo "$val" | grep -qE '^(ignore|skip)$'; then
    continue
  fi
  val="${val%$'\r'}"
  # buscar archivos candidatos en los módulos para esta clave de mapeo
  # Si la clave contiene el sufijo '|module', eso se incluye en la cadena de clave
  cmap="$key"
  module_override=""
  if echo "$cmap" | grep -q "\|"; then
    module_override="$(echo "$cmap" | cut -d'|' -f2)"
    cmap="$(echo "$cmap" | cut -d'|' -f1)"
  fi
  # si la clave tiene una barra, tratarla como ruta relativa
  if echo "$cmap" | grep -q '/' ; then
    # buscar por módulo la ruta relativa
    if [ -n "$module_override" ]; then
      # Resolver directorio del módulo (puede estar anidado, ej. modules/shell/fish)
      if [ -d "$MODULES_DIR/$module_override" ]; then
        mod_dir="$MODULES_DIR/$module_override"
      else
        mod_dir=$(find "$MODULES_DIR" -type d -name "$module_override" -print -quit)
      fi

      if [ -n "$mod_dir" ]; then
        # BUGFIX: Si cmap empieza con el nombre del módulo, eliminarlo para evitar duplicación
        # Ejemplo: cmap="cargo/config" module="cargo" -> debe buscar "config" en mod_dir
        search_path="$cmap"
        first_component="${cmap%%/*}"  # Obtener primer componente antes de /
        
        if [ "$first_component" = "$module_override" ]; then
          # Eliminar el primer componente que coincide con el módulo
          search_path="${cmap#*/}"  # Eliminar "cargo/" dejando solo "config"
        fi
        
        src="$mod_dir/$search_path"
        if [ -f "$src" ]; then
          found_paths=("$src")
        else
          found_paths=()
        fi
      else
        found_paths=()
      fi
    else
      # buscar en todos los módulos
      mapfile -t found_paths < <(find "$MODULES_DIR" -type f -path "*/$cmap" -print || true)
    fi
  else
    # solo nombre base; intentar localizar bajo modules
    if [ -n "$module_override" ]; then
      # Resolver directorio del módulo (puede estar anidado)
      if [ -d "$MODULES_DIR/$module_override" ]; then
        mod_dir="$MODULES_DIR/$module_override"
      else
        mod_dir=$(find "$MODULES_DIR" -type d -name "$module_override" -print -quit)
      fi

      if [ -n "$mod_dir" ]; then
        mapfile -t found_paths < <(find "$mod_dir" -type f -name "$cmap" -print || true)
      else
        found_paths=()
      fi
    else
      mapfile -t found_paths < <(find "$MODULES_DIR" -type f -name "$cmap" -print || true)
    fi
  fi

  if [ ${#found_paths[@]} -eq 0 ]; then
    # No existe un archivo fuente para este mapeo
    # Distinguir entre archivos template (.example) y archivos realmente faltantes
    if echo "$key" | grep -q '\.example$'; then
      # Es un archivo template, esto es informativo pero aceptable
      echo "OK: archivo de plantilla/ejemplo encontrado (permitido): $key" >&2
      continue
    else
      # Archivo realmente faltante - advertir pero no fallar
      echo "NOTA: el mapeo '$key' apunta a '$val' pero no se encontró archivo fuente en modules; omitiendo." >&2
      continue
    fi
  fi

  for src in "${found_paths[@]}"; do
    # Si el valor contiene comas, es un mapeo múltiple
    if [[ "$val" == *,* ]]; then
      # Procesar cada destino
      IFS=',' read -ra DEST_SPECS <<< "$val"
      for spec in "${DEST_SPECS[@]}"; do
        # Eliminar espacios al inicio/final
        spec_trimmed="$(echo "$spec" | sed -e 's/^\s*//' -e 's/\s*$//')"
        
        # Resolver spec a ruta completa usando helper
        expected=$(resolve_mapping_spec "$spec_trimmed")
        
        # Verificar este destino usando función helper
        if ! verify_symlink "$expected" "$src" "$key"; then
          errors=$((errors+1))
        fi
      done
    else
      # Mapeo simple (un solo destino)
      expected=$(resolve_mapping_spec "$val")
      
      # Verificar usando función helper
      if ! verify_symlink "$expected" "$src" "$key"; then
        errors=$((errors+1))
      fi
    fi
  done

done < <(printf '%s\n' "$map_keys")

if [ $errors -gt 0 ]; then
  echo "Se encontraron $errors errores de verificación de mapeos" >&2
  exit 2
fi

echo "Todos los mapeos declarados que tenían un archivo de origen se instalaron correctamente como enlaces simbólicos."

# Verificación adicional: probar que install.sh funciona desde diferentes directorios
echo ""
echo "Verificando que install.sh funciona desde diferentes directorios..."
if [ ${#MOD_LIST[@]} -gt 0 ]; then
  TEST_MODULE="${MOD_LIST[0]}"
  if [ -n "$TEST_MODULE" ] && [ -d "$TEST_MODULE" ]; then
    # Probar desde un subdirectorio temporal
    TEST_SUBDIR=$(mktemp -d)
    cd "$TEST_SUBDIR"
    # Limpiar el TARGET anterior y crear uno nuevo para esta prueba
    TEST_TARGET=$(mktemp -d)
    export TARGET="$TEST_TARGET"
    if ! "$ROOT/scripts/install.sh" "$TEST_MODULE" >/dev/null 2>&1; then
      echo "ERROR: install.sh falló cuando se ejecutó desde un directorio diferente ($TEST_SUBDIR)" >&2
      cd "$ROOT"
      rm -rf "$TEST_SUBDIR" "$TEST_TARGET"
      exit 1
    fi
    # Verificar que se crearon los enlaces simbólicos esperados
    if [ ! -L "$TEST_TARGET/.config" ] && [ ! -d "$TEST_TARGET/.config" ]; then
      # Al menos debería haber creado algo en el TARGET
      if [ -z "$(find "$TEST_TARGET" -mindepth 1 -maxdepth 2 2>/dev/null | head -1)" ]; then
        echo "ERROR: install.sh no creó ningún archivo cuando se ejecutó desde un directorio diferente" >&2
        cd "$ROOT"
        rm -rf "$TEST_SUBDIR" "$TEST_TARGET"
        exit 1
      fi
    fi
    cd "$ROOT"
    rm -rf "$TEST_SUBDIR" "$TEST_TARGET"
    echo "OK: install.sh funciona correctamente desde diferentes directorios"
  fi
fi

# Verificación de coherencia adicional: asegurar que no se crearon directorios top-level que coincidan con nombres base de mappings
bad_dirs=0
while IFS= read -r k; do
  [ -z "$k" ] && continue
  key="$k"
  if echo "$key" | grep -q "\|"; then
    key="$(echo "$key" | cut -d'|' -f1)"
  fi
  base="$(basename -- "$key")"
  if [[ "$base" == .* ]]; then
    bare="${base#.}"
    if [ -d "$TARGET/$bare" ]; then
      echo "ERROR: encontrado directorio no deseado $TARGET/$bare correspondiente al mapeo '$k' (se esperaba un symlink a archivo)" >&2
      bad_dirs=$((bad_dirs+1))
    fi
  else
    if [ -d "$TARGET/$base" ]; then
      echo "ERROR: encontrado directorio no deseado $TARGET/$base correspondiente al mapeo '$k' (se esperaba un symlink a archivo)" >&2
      bad_dirs=$((bad_dirs+1))
    fi
  fi
done < <(printf '%s\n' "$map_keys")

if [ $bad_dirs -gt 0 ]; then
  echo "Se encontraron $bad_dirs directorios no deseados que coinciden con nombres base de mapeos — limpia el layout del módulo o ajusta los mapeos." >&2
  exit 3
fi

exit 0
