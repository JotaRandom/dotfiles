#!/usr/bin/env bash
# Setup script to configure Git to use our .githooks directory for hooks
set -euo pipefail

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "Not in a git repository"
  exit 1
fi

git config core.hooksPath .githooks

echo "Configured Git hooks path to '.githooks' in this repository. If you want to revert, do: git config --unset core.hooksPath"
