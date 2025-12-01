#!/usr/bin/env bash
# Hook pre-commit multiplataforma: asegurar que scripts/*.sh sean ejecutables en el índice
set -euo pipefail

# Si PowerShell está disponible, ejecutar el hook de PowerShell en Windows
if command -v pwsh >/dev/null 2>&1; then
  pwsh -ExecutionPolicy Bypass -File "$(git rev-parse --show-toplevel)/.githooks/pre-commit.ps1"
  exit 0
fi

if command -v powershell >/dev/null 2>&1; then
  powershell -ExecutionPolicy Bypass -File "$(git rev-parse --show-toplevel)/.githooks/pre-commit.ps1"
  exit 0
fi

# Fallback: POSIX logic (for Bash)
STAGED=$(git diff --cached --name-only --diff-filter=ACM)
if [ -z "$STAGED" ]; then
  exit 0
fi

CHANGED=0
for f in $STAGED; do
  if [ -f "$f" ]; then
    if head -n 1 "$f" | grep -q '^#!'; then
      git update-index --chmod=+x "$f" && CHANGED=1 || true
    fi
  fi
done

if [ "$CHANGED" -eq 1 ]; then
  echo "Se marcaron archivos con shebang como ejecutables en el índice"
fi

exit 0
