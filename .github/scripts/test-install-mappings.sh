#!/usr/bin/env bash
set -euo pipefail

# Integration test to run scripts/install.sh in a temp TARGET and verify that any
# file declared in install-mappings.yml and present under modules is created at the
# mapped destination as a symlink pointing back to the module source.

ROOT=$(git rev-parse --show-toplevel 2>/dev/null || echo .)
MAP_FILE="$ROOT/install-mappings.yml"
INSTALL_SCRIPT="$ROOT/scripts/install.sh"
MODULES_DIR="$ROOT/modules"

if [ ! -x "$INSTALL_SCRIPT" ]; then
  echo "Installer not found or not executable: $INSTALL_SCRIPT" >&2
  exit 1
fi
if [ ! -f "$MAP_FILE" ]; then
  echo "No mapping file found at $MAP_FILE" >&2
  exit 1
fi

TMP=$(mktemp -d)
export TARGET="$TMP"
mkdir -p "$TARGET"

echo "Running installer against TARGET: $TARGET"
echo "Running installer against TARGET: $TARGET"
cd "$ROOT"
MOD_LIST=(modules/*)
if [ -e "${MOD_LIST[0]}" ]; then
  ./scripts/install.sh "${MOD_LIST[@]}" || true
else
  echo "No modules found in modules/ - nothing to install" >&2
fi

# Give installer a second to settle and produce symlinks if it forks background processes
sleep 1

# compute xdg base paths as the installer does
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$TARGET/.config}"
XDG_DATA_HOME="${XDG_DATA_HOME:-$TARGET/.local/share}"
XDG_STATE_HOME="${XDG_STATE_HOME:-$TARGET/.local/state}"
XDG_CACHE_HOME="${XDG_CACHE_HOME:-$TARGET/.cache}"

errors=0
# Read mappings: keys are the LHS before ':' (strip whitespace and comments)
while IFS= read -r mapping_key; do
  [ -z "$mapping_key" ] && continue
  # ignore comment lines / blank
  # split key|module if present
  key="$mapping_key"
  # resolution of the mapping value (dest prefix)
  # handle keys containing '|' or other meta-chars (escape) in grep
  safe_key=$(printf '%s' "$key" | sed -E 's/([][\\.*^$(){}+?|])/\\\1/g')
  val=$(grep -E "^[[:space:]]*${safe_key}:" -m1 "$MAP_FILE" | sed -E "s/^[[:space:]]*${safe_key}:[[:space:]]*//" | sed -E "s/#.*$//" | xargs || true)
  if [ -z "$val" ]; then
    # find module-specific or complex keys that include |module or contains path with / or |
    safe_key2=$(printf '%s' "$key" | sed -E 's/([][\\.*^$(){}+?||])/\\\1/g')
    val=$(grep -E "^[[:space:]]*${safe_key2}\|.*:" -m1 "$MAP_FILE" | sed -E "s/^[[:space:]]*${safe_key2}\|.*:[[:space:]]*//" | sed -E "s/#.*$//" | xargs || true)
  fi
  [ -z "$val" ] && continue
  # If mapping is ignore or skip, skip
  if echo "$val" | grep -qE '^(ignore|skip)$'; then
    continue
  fi
  # find candidate files in modules for this mapping key
  # If the key contains |module suffix, that will be included in the key string
  cmap="$key"
  module_override=""
  if echo "$cmap" | grep -q "\|"; then
    module_override="$(echo "$cmap" | cut -d'|' -f2)"
    cmap="$(echo "$cmap" | cut -d'|' -f1)"
  fi
  # if key has a slash, treat as relative path
  if echo "$cmap" | grep -q '/' ; then
    # search per module for the relative path
    if [ -n "$module_override" ]; then
      src="$MODULES_DIR/$module_override/$cmap"
      if [ -f "$src" ]; then
        found_paths=("$src")
      else
        found_paths=()
      fi
    else
      # search all modules
      mapfile -t found_paths < <(find "$MODULES_DIR" -type f -path "*/$cmap" -print || true)
    fi
  else
    # basename-only; try to locate under modules
    if [ -n "$module_override" ]; then
      mapfile -t found_paths < <(find "$MODULES_DIR/$module_override" -type f -name "$cmap" -print || true)
    else
      mapfile -t found_paths < <(find "$MODULES_DIR" -type f -name "$cmap" -print || true)
    fi
  fi

  if [ ${#found_paths[@]} -eq 0 ]; then
    # No source file exists for this mapping; warn but don't fail
    echo "NOTE: mapping '$key' maps to '$val' but no source file found under modules; skipping." >&2
    continue
  fi

  for src in "${found_paths[@]}"; do
    # compute expected destination path from mapping val
    case "$val" in
      xdg:*) expected="$XDG_CONFIG_HOME/${val#xdg:}" ;;
      xdg_state:*) expected="$XDG_STATE_HOME/${val#xdg_state:}" ;;
      xdg_data:*) expected="$XDG_DATA_HOME/${val#xdg_data:}" ;;
      xdg_cache:*) expected="$XDG_CACHE_HOME/${val#xdg_cache:}" ;;
      home:*) expected="$TARGET/${val#home:}" ;;
      *) expected="$TARGET/$val" ;;
    esac
    # check existence
    if [ ! -e "$expected" ]; then
      echo "ERROR: expected dest does not exist for mapping '$key': $expected (source: $src)" >&2
      errors=$((errors+1))
      continue
    fi
    if [ ! -L "$expected" ]; then
      echo "ERROR: expected dest is not a symlink for mapping '$key': $expected (source: $src)" >&2
      errors=$((errors+1))
      continue
    fi
    # Verify symlink target points to the module source
    targ=$(readlink -f "$expected")
    srcf=$(readlink -f "$src")
    if [ "$targ" = "$srcf" ]; then
      echo "OK: $expected -> $src"
      continue
    fi
    # If not a direct symlink into the repo, the installer may have created a sanitized
    # LF-only copy under $TARGET/.dotfiles_sanitized — accept that too, but validate.
    SAN_PREFIX="$TARGET/.dotfiles_sanitized"
    if [[ "$targ" == "$SAN_PREFIX"* ]]; then
      if [ ! -f "$targ" ]; then
        echo "ERROR: expected sanitized file to exist: $targ (source: $src)" >&2
        errors=$((errors+1))
        continue
      fi
      # Verify sanitized file contains no CRLF
      if grep -q $'\r' "$targ" 2>/dev/null || head -c 1 -q "$targ" | od -An -t x1 | grep -q '0d'; then
        echo "ERROR: sanitized file still contains CRLF: $targ" >&2
        errors=$((errors+1))
        continue
      fi
      echo "OK: $expected -> $targ (sanitized copy of $src)"
      continue
    fi
    echo "ERROR: symlink target mismatch for mapping '$key'. Expected <$srcf>, but found <$targ>. (dest: $expected)" >&2
    errors=$((errors+1))
    continue
    echo "OK: $expected -> $src" 
  done

done < <(sed -n 's/^[[:space:]]*//; s/#.*$//; s/:.*$//p' "$MAP_FILE" | sed '/^[[:space:]]*$/d')

if [ $errors -gt 0 ]; then
  echo "Found $errors mapping verification errors" >&2
  exit 2
fi

echo "All declared mappings that had a source file were installed correctly as symlinks." 

# Additional sanity check: ensure no top-level directories matching mapping basenames were created
bad_dirs=0
while IFS= read -r k; do
  [ -z "$k" ] && continue
  key="$k"
  if echo "$key" | grep -q "\|"; then
    key="$(echo "$key" | cut -d'|' -f1)"
  fi
  base="$(basename "$key")"
  if [[ "$base" == .* ]]; then
    bare="${base#.}"
    if [ -d "$TARGET/$bare" ]; then
      echo "ERROR: found undesired directory $TARGET/$bare corresponding to mapping '$k' (expect a file symlink)" >&2
      bad_dirs=$((bad_dirs+1))
    fi
  else
    if [ -d "$TARGET/$base" ]; then
      echo "ERROR: found undesired directory $TARGET/$base corresponding to mapping '$k' (expect a file symlink)" >&2
      bad_dirs=$((bad_dirs+1))
    fi
  fi
done < <(sed -n 's/^[[:space:]]*//; s/#.*$//; s/:.*$//p' "$MAP_FILE" | sed '/^[[:space:]]*$/d')

if [ $bad_dirs -gt 0 ]; then
  echo "Found $bad_dirs undesired directories matching mapping basenames — sanitize module layout or adjust mappings." >&2
  exit 3
fi

exit 0
