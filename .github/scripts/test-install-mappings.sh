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
MOD_LIST=(modules/*)

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

if [ -e "${MOD_LIST[0]}" ]; then
  ./scripts/install.sh "${MOD_LIST[@]}" || true
else
  echo "No se encontraron módulos en modules/ - nada que instalar" >&2
fi

# Give installer a second to settle and produce symlinks if it forks background processes
sleep 1

# calcular rutas base XDG tal como lo hace el instalador
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$TARGET/.config}"
XDG_DATA_HOME="${XDG_DATA_HOME:-$TARGET/.local/share}"
XDG_STATE_HOME="${XDG_STATE_HOME:-$TARGET/.local/state}"
XDG_CACHE_HOME="${XDG_CACHE_HOME:-$TARGET/.cache}"

errors=0
# Leer mapeos: extraer solo las líneas que contienen ':' para obtener las claves (evitar líneas de listas YAML que empiezan con '-')
# Usamos awk para eliminar comentarios y espacios y quedarnos solo con claves antes de ':'
map_keys=$(awk '{ line=$0; sub(/^[[:space:]]*/,"",line); sub(/#.*$/,"",line); if(index(line,":")>0){ key=line; sub(/:.*/,"",key); print key } }' "$MAP_FILE" | sed '/^[[:space:]]*$/d' | sort -u)

get_map_val(){
  # devuelve el valor de mapeo para una clave dada (puede devolver lista o único valor)
  local key="$1"
  local raw line val
  while IFS= read -r raw; do
    line="${raw%%#*}"
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

printf '%s\n' "$map_keys" | while IFS= read -r mapping_key; do
  [ -z "$mapping_key" ] && continue
  key="$mapping_key"
  val=""
  val=$(get_map_val "$key" || true)
  [ -z "$val" ] && continue
  # Si el mapeo es 'ignore' o 'skip', omitir
  if echo "$val" | grep -qE '^(ignore|skip)$'; then
    continue
  fi
  # buscar archivos candidatos en los módulos para esta clave de mapeo
  # Si la clave contiene el sufijo '|module', eso se incluye en la cadena de clave
  cmap="$key"
  module_override=""
  if echo "$cmap" | grep -q "\|"; then
    module_override="$(echo "$cmap" | cut -d'|' -f2)"
    cmap="$(echo "$cmap" | cut -d'|' -f1)"
  fi
  # if key has a slash, treat as relative path
  if echo "$cmap" | grep -q '/' ; then
    # buscar por módulo la ruta relativa
    if [ -n "$module_override" ]; then
      src="$MODULES_DIR/$module_override/$cmap"
      if [ -f "$src" ]; then
        found_paths=("$src")
      else
        found_paths=()
      fi
    else
      # search all modules
      mapfile -t found_paths < <(find "$MODULES_DIR" -type f -path "*/$cmap" -print || true)
    fi
  else
    # basename-only; try to locate under modules
    if [ -n "$module_override" ]; then
      mapfile -t found_paths < <(find "$MODULES_DIR/$module_override" -type f -name "$cmap" -print || true)
    else
      mapfile -t found_paths < <(find "$MODULES_DIR" -type f -name "$cmap" -print || true)
    fi
  fi

  if [ ${#found_paths[@]} -eq 0 ]; then
    # No existe un archivo fuente para este mapeo; advertir pero no fallar
    echo "NOTA: el mapeo '$key' apunta a '$val' pero no se encontró archivo fuente en modules; omitiendo." >&2
    continue
  fi

  for src in "${found_paths[@]}"; do
    # calcular la ruta de destino esperada desde el valor del mapeo
    case "$val" in
      xdg:*) expected="$XDG_CONFIG_HOME/${val#xdg:}" ;;
      xdg_state:*) expected="$XDG_STATE_HOME/${val#xdg_state:}" ;;
      xdg_data:*) expected="$XDG_DATA_HOME/${val#xdg_data:}" ;;
      xdg_cache:*) expected="$XDG_CACHE_HOME/${val#xdg_cache:}" ;;
      home:*) expected="$TARGET/${val#home:}" ;;
      *) expected="$TARGET/$val" ;;
    esac
    # check existence
    if [ ! -e "$expected" ]; then
      echo "ERROR: el destino esperado no existe para el mapeo '$key': $expected (origen: $src)" >&2
      errors=$((errors+1))
      continue
    fi
    if [ ! -L "$expected" ]; then
      echo "ERROR: el destino esperado no es un enlace simbólico para el mapeo '$key': $expected (origen: $src)" >&2
      errors=$((errors+1))
      continue
    fi
    # Verificar que el objetivo del enlace simbólico apunta al archivo fuente en el módulo
    targ=$(readlink -f "$expected")
    srcf=$(readlink -f "$src")
    if [ "$targ" = "$srcf" ]; then
      echo "OK: $expected -> $src"
      continue
    fi
    # Si no es un enlace simbólico directo al repositorio, el instalador pudo haber creado una copia
    # solo-LF saneada en $TARGET/.dotfiles_sanitized — aceptarla también, pero validarla.
    SAN_PREFIX="$TARGET/.dotfiles_sanitized"
    if [[ "$targ" == "$SAN_PREFIX"* ]]; then
      if [ ! -f "$targ" ]; then
        echo "ERROR: no existe el archivo saneado esperado: $targ (origen: $src)" >&2
        errors=$((errors+1))
        continue
      fi
      # Verify sanitized file contains no CRLF
      if grep -q $'\r' "$targ" 2>/dev/null || head -c 1 -q "$targ" | od -An -t x1 | grep -q '0d'; then
        echo "ERROR: el archivo saneado aún contiene CRLF: $targ" >&2
        errors=$((errors+1))
        continue
      fi
      echo "OK: $expected -> $targ (copia saneada de $src)"
      continue
    fi
    echo "ERROR: discrepancia en el objetivo del enlace para el mapeo '$key'. Se esperaba <$srcf>, pero se encontró <$targ>. (dest: $expected)" >&2
    errors=$((errors+1))
    continue
    echo "OK: $expected -> $src" 
  done

done

if [ $errors -gt 0 ]; then
  echo "Se encontraron $errors errores de verificación de mapeos" >&2
  exit 2
fi

echo "Todos los mapeos declarados que tenían un archivo de origen se instalaron correctamente como enlaces simbólicos." 

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
