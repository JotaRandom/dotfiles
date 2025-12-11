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
  # omitir archivos que son dotfiles (el instalador 'dotifica' por defecto, salvo en presencia de un mapeo)
  if [[ "$fname" == .* ]]; then
    # permitir mapeo explícito, pero omitir dotfiles predeterminados
    continue
  fi
  # si no está presente en las claves de mapeo, es un error (el archivo de mapeo debería enumerar cada archivo raíz)
    if [ -z "${MAP_SET[$fname]:-}" ]; then
    echo "ERROR: archivo a nivel raíz en módulos sin mapeo: $fname (encontrado en $file)" >&2
    errors=$((errors+1))
  fi
done < <(find modules -maxdepth 2 -mindepth 2 -type f -print0 || true)

if [ $errors -gt 0 ]; then
  echo "Se detectaron $errors archivos en la raíz de módulos sin mapeo — añade entradas en install-mappings.yml (usa 'ignore:' para README.md, etc.)." >&2
  exit 2
fi

echo "Todos los archivos raíz de módulos están cubiertos por install-mappings.yml (o son dotfiles)."
