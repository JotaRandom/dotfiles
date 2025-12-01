#!/usr/bin/env bash
set -euo pipefail

# Verificación simple para evitar reintroducir mensajes en inglés en archivos de usuario
# Excluye 'machines/' y 'docs/' por política del repo

PATTERN_SIMPLE='Please\s|Usage:|Default to|Please see|Please note|Refusing to run|Refusing|TODO:|Error:|Warning:|Info:|Debug:|Success:|Failed to|is not valid|is invalid|is required|not found|not available|is missing|are missing|load module|Load module|module not found|Module not found|configuration file|Configuration file|command not found|Command not found|is deprecated|is obsolete|is outdated|is unrecognized|unknown option|Unknown option|unrecognized option|Unrecognized option|set to default|Set to default|overriding with default|Overriding with default'
FILES=$(git ls-files | grep -E '^(scripts/|modules/|\.githooks/|\.github/|distros/|PKGBUILD/)') || true

FOUND=0
for f in $FILES; do
  # skip machines and docs
  if [[ "$f" == machines/* || "$f" == docs/* ]]; then continue; fi
  # check only for comment/text lines and echo/write-host strings
  # Only search in comments or echo/write-host messages to avoid code token false-positives
  if grep -I -nH -E "^[[:space:]]*#.*(${PATTERN_SIMPLE})" "$f" >/dev/null 2>&1 || grep -I -nH -E "echo .*(['\"]).*(${PATTERN_SIMPLE}).*\1" "$f" >/dev/null 2>&1 || grep -I -nH -E "Write-(Host|Warning|Output).*(['\"]).*(${PATTERN_SIMPLE}).*\1" "$f" >/dev/null 2>&1; then
    # Exclude some known exceptions (e.g., license files, or internal code tokens)
    case "$f" in
      *LICENSE*|*.md|*.txt) continue ;;
    esac
    echo "Encontrado texto en inglés en $f"
    grep -nH -E "^[[:space:]]*#.*(${PATTERN_SIMPLE})" "$f" || true
    grep -nH -E "echo .*(['\"]).*(${PATTERN_SIMPLE}).*\1" "$f" || true
    grep -nH -E "Write-(Host|Warning|Output).*(['\"]).*(${PATTERN_SIMPLE}).*\1" "$f" || true
    FOUND=1
  fi
done

# Check if stow is referenced anywhere (we intentionally removed it previously)
if git ls-files | xargs grep -I -n "\bstow\b" >/dev/null 2>&1; then
  if git ls-files | xargs grep -I -n "\bstow\b" | grep -vE '^machines/' | grep -vE '^docs/' >/dev/null 2>&1; then
    echo "ERROR: se detectó 'stow' en el repo (busca en archivos de configuración o scripts)." >&2
    FOUND=1
  fi
fi

if [ "$FOUND" -eq 1 ]; then
  echo "Se encontraron strings en inglés. Por favor, tradúcelos y vuelve a commitear." >&2
  exit 2
fi
echo "Verificación de texto en inglés completada (no se encontraron coincidencias)."
exit 0
