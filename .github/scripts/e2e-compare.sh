#!/usr/bin/env bash
set -euo pipefail

# End-to-end installer verification (Linux)
# (Copied into .github/scripts for CI-only usage; kept out of top-level scripts/.)

REPO_ROOT=$(git rev-parse --show-toplevel 2>/dev/null || echo .)
MAPPINGS="$REPO_ROOT/install-mappings.yml"

if [ ! -f "$MAPPINGS" ]; then
  echo "install-mappings.yml not found at $MAPPINGS" >&2
  exit 1
fi

TMPROOT=$(mktemp -d)
HOME_TMP="$TMPROOT/home"
XDG_CONFIG_TMP="$TMPROOT/config"
XDG_STATE_TMP="$TMPROOT/state"
XDG_DATA_TMP="$TMPROOT/data"
XDG_CACHE_TMP="$TMPROOT/cache"
mkdir -p "$HOME_TMP" "$XDG_CONFIG_TMP" "$XDG_STATE_TMP" "$XDG_DATA_TMP" "$XDG_CACHE_TMP"

echo "TMPROOT=$TMPROOT"

# Install stow if available via apt/pacman/dnf (best-effort)
if command -v apt >/dev/null 2>&1; then
  sudo apt-get update && sudo apt-get install -y stow || true
elif command -v pacman >/dev/null 2>&1; then
  sudo pacman -Syu --noconfirm stow || true
elif command -v dnf >/dev/null 2>&1; then
  sudo dnf install -y stow || true
else
  echo "No package manager installer detected; continuing without installing stow (installer will still map root files)."
fi

export HOME="$HOME_TMP"
export XDG_CONFIG_HOME="$XDG_CONFIG_TMP"
export XDG_STATE_HOME="$XDG_STATE_TMP"
export XDG_DATA_HOME="$XDG_DATA_TMP"
export XDG_CACHE_HOME="$XDG_CACHE_TMP"

cd "$REPO_ROOT"

MODULES_LIST=$(find modules -mindepth 2 -maxdepth 2 -type d | tr '\n' ' ')
echo "Applying modules: $MODULES_LIST"
./scripts/install.sh $MODULES_LIST

echo "Collecting symlinks created in temporary HOME/XDG..."

while IFS= read -r -d '' link; do
  target=$(readlink -f "$link")
  echo "$link -> $target"
done < <(find "$HOME_TMP" "$XDG_CONFIG_TMP" "$XDG_STATE_TMP" "$XDG_DATA_TMP" "$XDG_CACHE_TMP" -type l -lname "$REPO_ROOT/modules/*" -print0 || true)

exit 0
