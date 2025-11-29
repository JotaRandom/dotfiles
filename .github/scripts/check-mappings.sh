#!/usr/bin/env bash
set -euo pipefail

# Verify every module root file is declared in install-mappings.yml (or is explicitly ignored)
MAPPINGS_FILE="$(git rev-parse --show-toplevel 2>/dev/null || echo .)/install-mappings.yml"
if [ ! -f "$MAPPINGS_FILE" ]; then
  echo "No mapping file found at $MAPPINGS_FILE — aborting check" >&2
  exit 1
fi

# Collect mapping keys (strip module suffix after '|')
map_keys=$(sed -n 's/^[[:space:]]*//;s/#.*//;s/:.*$//;s/|.*$//p' "$MAPPINGS_FILE" | sort -u)
declare -A MAP_SET
while IFS= read -r k; do
  [ -z "$k" ] && continue
  MAP_SET["$k"]=1
done <<<"$map_keys"

errors=0
while IFS= read -r -d $'\0' file; do
  fname=$(basename "$file")
  # skip files that are dotfiles (installer dotifies by default unless mapping exists)
  if [[ "$fname" == .* ]]; then
    # still allow explicit mapping, but skip default dotfiles
    continue
  fi
  # if not present in mapping keys, it's an error (the mapping file should list every root-level file)
  if [ -z "${MAP_SET[$fname]:-}" ]; then
    echo "ERROR: root-level file in modules not mapped: $fname (found in $file)" >&2
    errors=$((errors+1))
  fi
done < <(find modules -maxdepth 2 -mindepth 2 -type f -print0 || true)

if [ $errors -gt 0 ]; then
  echo "Found $errors unmapped module root files — add entries to install-mappings.yml (use 'ignore:' for README.md etc)." >&2
  exit 2
fi

echo "All module root files are covered by install-mappings.yml (or are dotfiles)."
