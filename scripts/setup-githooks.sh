#!/usr/bin/env bash
# Setup script to configure Git to use our .githooks directory for hooks
set -euo pipefail

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "Not in a git repository"
  exit 1
fi

git config core.hooksPath .githooks

echo "Configured Git hooks path to '.githooks' in this repository. If you want to revert, do: git config --unset core.hooksPath"

# Ensure scripts/*.sh with a shebang are executable in the index (idempotent)
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  for f in $(git ls-files 2>/dev/null || true); do
    if [ -f "$f" ]; then
      if head -n 1 "$f" | grep -q '^#!'; then
        git update-index --chmod=+x "$f" || true
      fi
    fi
  done
  echo "Ensured executable bit is set for tracked files with a shebang in the git index."
fi
