#!/bin/bash
set -x
cd "$(dirname "$0")"

key=".bashrc|bash"
cmap=$(echo "$key" | cut -d'|' -f1)
module_override=$(echo "$key" | cut -d'|' -f2)

echo "=== DEBUG ==="
echo "key=$key"
echo "cmap=$cmap"
echo "module_override=$module_override"

# Buscar directorio del módulo
MODULES_DIR="modules"
if [ -d "$MODULES_DIR/$module_override" ]; then
  mod_dir="$MODULES_DIR/$module_override"
  echo "Found direct: $mod_dir"
else
  mod_dir=$(find "$MODULES_DIR" -type d -name "$module_override" -print -quit)
  echo "Found via find: $mod_dir"
fi

echo "mod_dir=$mod_dir"

# Buscar archivo
if [ -n "$mod_dir" ]; then
  echo "Searching in: $mod_dir"
  found=$(find "$mod_dir" -type f -name "$cmap" -print)
  echo "Found files: $found"
  if [ -z "$found" ]; then
    echo "NO FILES FOUND!"
  fi
else
  echo "ERROR: mod_dir is empty!"
fi
