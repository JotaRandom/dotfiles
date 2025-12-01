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
  # empty files are templates
  if [ ! -s "$f" ]; then
    return 0
  fi
  # For JSON files, treat {} or [] as template
  if [[ "${f,,}" == *.json ]]; then
    trimmed=$(tr -d '[:space:]' < "$f") || trimmed=""
    if [ "$trimmed" = "{}" ] || [ "$trimmed" = "[]" ]; then
      return 0
    fi
  fi
  # Private keys are secrets if non-empty
  bn=$(basename "$f")
  if [[ "$bn" =~ ^id_(rsa|ed25519)$ ]] || [[ "$bn" =~ ^id_.*_priv$ ]]; then
    return 1
  fi
  # If every non-empty line begins with a comment marker (#, //, ;) treat as template
  non_comment_count=$(grep -E -v '^[[:space:]]*($|#|//|;)' "$f" | wc -l | tr -d '[:space:]') || non_comment_count=0
  if [ "$non_comment_count" -eq 0 ]; then
    return 0
  fi
  return 1
}

# Patterns to scan for: files that often contain credentials or secrets.
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
  echo "Refusing to run mapping tests: found $secret_errors likely-secret file(s) under modules." >&2
  exit 4
fi

if [ -e "${MOD_LIST[0]}" ]; then
  ./scripts/install.sh "${MOD_LIST[@]}" || true
else
  echo "No modules found in modules/ - nothing to install" >&2
fi

# Give installer a second to settle and produce symlinks if it forks background processes
sleep 1

# compute xdg base paths as the installer does
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$TARGET/.config}"
XDG_DATA_HOME="${XDG_DATA_HOME:-$TARGET/.local/share}"
XDG_STATE_HOME="${XDG_STATE_HOME:-$TARGET/.local/state}"
XDG_CACHE_HOME="${XDG_CACHE_HOME:-$TARGET/.cache}"

errors=0
# Read mappings: keys are the LHS before ':' (strip whitespace and comments)
while IFS= read -r mapping_key; do
  [ -z "$mapping_key" ] && continue
  # ignore comment lines / blank
  # split key|module if present
  key="$mapping_key"
  # resolution of the mapping value (dest prefix)
  # handle keys containing '|' or other meta-chars (escape) in grep
  safe_key=$(printf '%s' "$key" | sed -E 's/([][\\.*^$(){}+?|])/\\\1/g')
  val=$(grep -E "^[[:space:]]*${safe_key}:" -m1 "$MAP_FILE" | sed -E "s/^[[:space:]]*${safe_key}:[[:space:]]*//" | sed -E "s/#.*$//" | xargs || true)
  if [ -z "$val" ]; then
    # find module-specific or complex keys that include |module or contains path with / or |
    safe_key2=$(printf '%s' "$key" | sed -E 's/([][\\.*^$(){}+?||])/\\\1/g')
    val=$(grep -E "^[[:space:]]*${safe_key2}\|.*:" -m1 "$MAP_FILE" | sed -E "s/^[[:space:]]*${safe_key2}\|.*:[[:space:]]*//" | sed -E "s/#.*$//" | xargs || true)
  fi
  [ -z "$val" ] && continue
  # If mapping is ignore or skip, skip
  if echo "$val" | grep -qE '^(ignore|skip)$'; then
    continue
  fi
  # find candidate files in modules for this mapping key
  # If the key contains |module suffix, that will be included in the key string
  cmap="$key"
  module_override=""
  if echo "$cmap" | grep -q "\|"; then
    module_override="$(echo "$cmap" | cut -d'|' -f2)"
    cmap="$(echo "$cmap" | cut -d'|' -f1)"
  fi
  # if key has a slash, treat as relative path
  if echo "$cmap" | grep -q '/' ; then
    # search per module for the relative path
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
    # No source file exists for this mapping; warn but don't fail
    echo "NOTA: el mapeo '$key' apunta a '$val' pero no se encontró archivo fuente en modules; omitiendo." >&2
    continue
  fi

  for src in "${found_paths[@]}"; do
    # compute expected destination path from mapping val
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
    # Verify symlink target points to the module source
    targ=$(readlink -f "$expected")
    srcf=$(readlink -f "$src")
    if [ "$targ" = "$srcf" ]; then
      echo "OK: $expected -> $src"
      continue
    fi
    # If not a direct symlink into the repo, the installer may have created a sanitized
    # LF-only copy under $TARGET/.dotfiles_sanitized — accept that too, but validate.
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

done < <(sed -n 's/^[[:space:]]*//; s/#.*$//; s/:.*$//p' "$MAP_FILE" | sed '/^[[:space:]]*$/d')

if [ $errors -gt 0 ]; then
  echo "Se encontraron $errors errores de verificación de mappings" >&2
  exit 2
fi

echo "All declared mappings that had a source file were installed correctly as symlinks." 

# Additional sanity check: ensure no top-level directories matching mapping basenames were created
bad_dirs=0
while IFS= read -r k; do
  [ -z "$k" ] && continue
  key="$k"
  if echo "$key" | grep -q "\|"; then
    key="$(echo "$key" | cut -d'|' -f1)"
  fi
  base="$(basename "$key")"
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
done < <(sed -n 's/^[[:space:]]*//; s/#.*$//; s/:.*$//p' "$MAP_FILE" | sed '/^[[:space:]]*$/d')

if [ $bad_dirs -gt 0 ]; then
  echo "Se encontraron $bad_dirs directorios no deseados que coinciden con nombres base de mappings — limpia el layout del módulo o ajusta los mappings." >&2
  exit 3
fi

exit 0
