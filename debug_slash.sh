#!/bin/bash
set -x
cd /mnt/c/Users/Usuario/source/repos/dotfiles

# Test case: cargo/config|cargo
key="cargo/config|cargo"
cmap=$(echo "$key" | cut -d'|' -f1)
module_override=$(echo "$key" | cut -d'|' -f2)

echo "=== DEBUG ==="
echo "key=$key"
echo "cmap=$cmap"
echo "module_override=$module_override"

# Check if cmap has '/'
if echo "$cmap" | grep -q '/' ; then
  echo "HAS SLASH - treating as relative path"
  
  if [ -n "$module_override" ]; then
    echo "Module override: $module_override"
    
    # Find module directory
    if [ -d "modules/$module_override" ]; then
      mod_dir="modules/$module_override"
    else
      mod_dir=$(find modules -type d -name "$module_override" -print -quit)
    fi
    
    echo "mod_dir=$mod_dir"
    
    if [ -n "$mod_dir" ]; then
      # Try to find the file
      src="$mod_dir/$cmap"
      echo "Looking for: $src"
      
      if [ -f "$src" ]; then
        echo "FOUND: $src"
      else
        echo "NOT FOUND: $src"
      fi
    fi
  fi
else
  echo "NO SLASH - treating as basename"
fi
