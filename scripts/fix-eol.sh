#!/usr/bin/env bash
set -euo pipefail

# Busca archivos rastreados por git que contengan caracteres CR (\r), los limpia
# y hace un commit agrupado. Ejecutar desde la raíz del repositorio.

cd "$(dirname "${BASH_SOURCE[0]}")/.."

mapfile -d '' -t allfiles < <(git ls-files -z)
cr_files=()
for f in "${allfiles[@]}"; do
  if [ -f "$f" ] && grep -q $'\r' "$f" 2>/dev/null; then
    cr_files+=("$f")
  fi
done

if [ ${#cr_files[@]} -eq 0 ]; then
  echo "No CR files found"
  exit 0
fi

echo "Files to fix:"
printf '%s\n' "${cr_files[@]}"

for f in "${cr_files[@]}"; do
  echo "Fixing: $f"
  # crear copia temporal y reemplazar
  tr -d '\r' < "$f" > "$f.fixed" && mv "$f.fixed" "$f" || echo "failed: $f"
done

git add -A
git commit -m "fix(eol): remove CR from files" || echo "No commit created"

echo "Done."
