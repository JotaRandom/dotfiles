#!/usr/bin/env bash
set -euo pipefail
MAPPINGS_FILE="$(git rev-parse --show-toplevel)/install-mappings.yml"
if [ ! -f "$MAPPINGS_FILE" ]; then
  echo "No se encontró $MAPPINGS_FILE" >&2
  exit 1
fi

declare -A _MAPPER_GLOBAL _MAPPER_MODULE
mapfile -t _map_lines < "$MAPPINGS_FILE"
i=0
while [ $i -lt ${#_map_lines[@]} ]; do
  line="${_map_lines[$i]}"
  line="${line%%#*}"
  line="${line#${line%%[![:space:]]*}}"
  line="${line%${line##*[![:space:]]}}"
  [ -z "$line" ] && { i=$((i+1)); continue; }
  if [[ "$line" =~ ^default_action:[[:space:]]*([a-zA-Z_]+) ]]; then
    i=$((i+1)); continue
  fi

  if [[ "$line" =~ ^([^:]+):[[:space:]]*(.+)$ ]]; then
    key="${BASH_REMATCH[1]}"; val="${BASH_REMATCH[2]}"
    key="${key#${key%%[![:space:]]*}}"; key="${key%${key##*[![:space:]]}}"
    val="${val#${val%%[![:space:]]*}}"; val="${val%${val##*[![:space:]]}}"
  elif [[ "$line" =~ ^([^:]+):[[:space:]]*$ ]]; then
    key="${BASH_REMATCH[1]}"
    vals=""
    j=$((i+1))
    while [ $j -lt ${#_map_lines[@]} ]; do
      nxt="${_map_lines[$j]}"
      nxt="${nxt%%#*}"
      nxt="${nxt#${nxt%%[![:space:]]*}}"
      nxt="${nxt%${nxt##*[![:space:]]}}"
      if [[ "$nxt" =~ ^-[[:space:]]*(.+)$ ]]; then
        item="${BASH_REMATCH[1]}"
        item="${item#${item%%[![:space:]]*}}"
        item="${item%${item##*[![:space:]]}}"
        if [ -z "$vals" ]; then
          vals="$item"
        else
          vals="${vals},${item}"
        fi
        j=$((j+1)); continue
      fi
      break
    done
    val="$vals"
    i=$((j-1))
  else
    i=$((i+1)); continue
  fi

  if [[ "$key" == *"|"* ]]; then
    name="${key%%|*}"; mod="${key##*|}"
    k="$name|$mod"
    if [[ -n "${_MAPPER_MODULE[$k]+x}" ]]; then
      _MAPPER_MODULE["$k"]="${_MAPPER_MODULE[$k]},${val}"
    else
      _MAPPER_MODULE["$k"]="$val"
    fi
  else
    if [[ -n "${_MAPPER_GLOBAL[$key]+x}" ]]; then
      _MAPPER_GLOBAL["$key"]="${_MAPPER_GLOBAL[$key]},${val}"
    else
      _MAPPER_GLOBAL["$key"]="$val"
    fi
  fi
  i=$((i+1))
done

echo "--- GLOBAL (${#_MAPPER_GLOBAL[@]}) ---" > /tmp/inspect_mappings_global.txt
for k in "${!_MAPPER_GLOBAL[@]}"; do echo "$k => ${_MAPPER_GLOBAL[$k]}" >> /tmp/inspect_mappings_global.txt; done
echo "--- MODULE (${#_MAPPER_MODULE[@]}) ---" > /tmp/inspect_mappings_module.txt
for k in "${!_MAPPER_MODULE[@]}"; do echo "$k => ${_MAPPER_MODULE[$k]}" >> /tmp/inspect_mappings_module.txt; done
echo "Wrote /tmp/inspect_mappings_global.txt and /tmp/inspect_mappings_module.txt"
cat /tmp/inspect_mappings_global.txt
cat /tmp/inspect_mappings_module.txt
