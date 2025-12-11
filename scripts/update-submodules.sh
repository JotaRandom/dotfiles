#!/usr/bin/env bash
set -euo pipefail

TARGET_DIR="distros/PKGBUILD"
if [ $# -gt 0 ]; then
  # update single package
  TARGET_DIR="$TARGET_DIR/$1"
fi

  if [ ! -d "$TARGET_DIR" ]; then
  echo "Directorio destino $TARGET_DIR no existe"
  exit 1
fi

echo "Actualizando submodules en $TARGET_DIR..."
for d in "$TARGET_DIR"/*; do
  if [ -d "$d" ]; then
    if [ -f "$d/.git" ] || git -C "$d" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
      echo "Actualizando $(basename -- "$d")..."
      git -C "$d" fetch --all
      git -C "$d" pull --ff-only || git -C "$d" pull --no-edit
      git add "$d"
    fi
  fi
done

echo "Confirmando actualizaciones de submódulos (si hay)"
git commit -m "chore: update PKGBUILD submodules" --no-verify || echo "No hay cambios para commitear"
echo "Listo. Revisa con 'git status' y sube tu rama de trabajo." 
