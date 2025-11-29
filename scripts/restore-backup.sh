#!/usr/bin/env bash
set -euo pipefail

# restore-backup.sh: restore files backed up by the dotfiles installer
# Usage:
#   scripts/restore-backup.sh               # list available backups
#   scripts/restore-backup.sh <timestamp>   # show modules inside a backup
#   scripts/restore-backup.sh <timestamp> <module>  # restore one module

BACKUP_DIR="$HOME/.dotfiles_backup"

usage() {
  cat <<EOF
Usage:
  $0               # list available backups
  $0 <timestamp>   # list modules inside timestamp
  $0 <timestamp> <module>  # restore the module contents

By default the script prompts for confirmation before overwriting files in your home.
EOF
}

if [ "$#" -eq 0 ]; then
  if [ -d "$BACKUP_DIR" ]; then
    echo "Available backups:";
    ls -1 "$BACKUP_DIR";
  else
    echo "No backups found at: $BACKUP_DIR";
  fi
  exit 0
fi

TIMESTAMP="$1"
if [ ! -d "$BACKUP_DIR/$TIMESTAMP" ]; then
  echo "Backup timestamp not found: $TIMESTAMP" >&2
  exit 2
fi

# support help
if [ "$TIMESTAMP" = "-h" ] || [ "$TIMESTAMP" = "--help" ]; then
  usage
  exit 0
fi

if [ "$#" -eq 1 ]; then
  echo "Modules in backup $TIMESTAMP:";
  ls -1 "$BACKUP_DIR/$TIMESTAMP";
  exit 0
fi

MODULE="$2"
SRC="$BACKUP_DIR/$TIMESTAMP/$MODULE"
if [ ! -d "$SRC" ]; then
  echo "Module not found in backup: $MODULE" >&2
  exit 3
fi

echo "About to restore module '$MODULE' from backup '$TIMESTAMP' to $HOME"
read -r -p "Proceed and overwrite files in $HOME? [y/N]: " confirm
if [[ "${confirm,,}" != "y" && "${confirm,,}" != "yes" ]]; then
  echo "Aborted. No files changed.";
  exit 0
fi

# use rsync where available; otherwise fallback to cp -a
if command -v rsync >/dev/null 2>&1; then
  rsync -a --backup --suffix=".restore-bak" "$SRC/" "$HOME/"
else
  # cp -a may not support backups; warn user
  echo "rsync not found; using cp -a and overwriting files (no automatic backup)."
  cp -a "$SRC/" "$HOME/"
fi

echo "Restore complete. If you used rsync, existing files were backed up to <filename>.restore-bak"
exit 0
