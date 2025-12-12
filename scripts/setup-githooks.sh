#!/usr/bin/env bash
# Script de configuración para indicarle a Git que use el directorio .githooks para hooks
set -euo pipefail

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "No se encuentra dentro de un repositorio Git"
  exit 1
fi

git config core.hooksPath .githooks

echo "Ruta de hooks de Git configurada a '.githooks' en este repositorio. Para revertir: git config --unset core.hooksPath"

# Asegurar que scripts/*.sh con shebang sean ejecutables en el índice (idempotente)
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  git ls-files -z 2>/dev/null | while IFS= read -r -d '' f; do
    if [ -f "$f" ]; then
      if head -n 1 "$f" | grep -q '^#!'; then
        git update-index --chmod=+x "$f" || true
      fi
    fi
  done
  echo "Se aseguró que los archivos con shebang tengan el bit ejecutable en el índice de Git."
fi
