#!/usr/bin/env bash
set -euo pipefail

# Verificar que cada archivo en la raíz de un módulo esté declarado en install-mappings.yml (o esté explícitamente ignorado)
MAPPINGS_FILE="$(git rev-parse --show-toplevel 2>/dev/null || echo .)/install-mappings.yml"
if [ ! -f "$MAPPINGS_FILE" ]; then
  echo "No se encontró el archivo de mapeos en $MAPPINGS_FILE — abortando la verificación" >&2
  exit 1
fi

# Recopilar claves de mapeo de forma robusta: ignorar comentarios y
# entradas de lista YAML (líneas que comienzan con '-') y extraer la
# clave antes de los dos puntos. También eliminar el sufijo de módulo
# después de '|' si está presente.
map_keys=$(awk '
  /^[[:space:]]*#/ { next }
  /^[[:space:]]*-+[[:space:]]*/ { next }
  {
    line = $0
    sub(/^[[:space:]]*/, "", line)
    idx = index(line, ":")
    if (idx > 0) {
      key = substr(line, 1, idx-1)
      # recortar espacios finales
      sub(/[[:space:]]+$/, "", key)
      # eliminar sufijo de módulo si existe
      sub(/\|.*/, "", key)
      if (length(key) > 0) print key
    }
  }
' "$MAPPINGS_FILE" | sort -u)

declare -A MAP_SET
while IFS= read -r k; do
  [ -z "$k" ] && continue
  MAP_SET["$k"]=1
done <<<"$map_keys"

errors=0
while IFS= read -r -d $'\0' file; do
  fname=$(basename -- "$file")
  # ruta relativa desde modules/ (p. ej. "cargo/config")
  relpath=${file#*/}

  # omitir archivos que son dotfiles (el instalador 'dotifica' por defecto, salvo en presencia de un mapeo)
  if [[ "$fname" == .* ]]; then
    continue
  fi

  # Comprobar varias formas de clave en los mapeos:
  #  - nombre base (p. ej. "config")
  #  - ruta relativa "module/file" (p. ej. "cargo/config")
  # Esto permite que install-mappings.yml use cualquiera de las dos convenciones.
  if [ -n "${MAP_SET[$fname]:-}" ] || [ -n "${MAP_SET[$relpath]:-}" ]; then
    continue
  fi

  # Tampoco es un error si la clave aparece con prefijo de directorio distinto (compatibilidad extra)
  # comprobar claves que terminen en "/$fname" (por si alguien puso "some/path/$fname")
  matched=0
  for k in "${!MAP_SET[@]}"; do
    case "$k" in
      */$fname) matched=1; break;;
    esac
  done
  if [ $matched -eq 1 ]; then
    continue
  fi

  echo "ERROR: archivo a nivel raíz en módulos sin mapeo: $fname (encontrado en $file)" >&2
  errors=$((errors+1))
done < <(find modules -maxdepth 2 -mindepth 2 -type f -print0 || true)

if [ $errors -gt 0 ]; then
  echo "Se detectaron $errors archivos en la raíz de módulos sin mapeo — añade entradas en install-mappings.yml (usa 'ignore:' para README.md, etc.)." >&2
  exit 2
fi

echo "Todos los archivos raíz de módulos están cubiertos por install-mappings.yml (o son dotfiles)."
