#!/usr/bin/env bash
set -euo pipefail

# restore-backup.sh: restaura archivos respaldados por el instalador de dotfiles
# Uso:
#   scripts/restore-backup.sh               # listar respaldos disponibles
#   scripts/restore-backup.sh <timestamp>   # mostrar módulos dentro de un respaldo
#   scripts/restore-backup.sh <timestamp> <module>  # restaurar un módulo

BACKUP_DIR="$HOME/.dotfiles_backup"

usage() {
  cat <<'EOF'
Uso:
  $0               # lista los respaldos disponibles
  $0 <timestamp>   # muestra los módulos dentro del respaldo
  $0 <timestamp> <module>  # restaura un módulo
EOF
}

if [ "$#" -eq 0 ]; then
  if [ -d "$BACKUP_DIR" ]; then
      echo "Respaldos disponibles:";
    ls -1 "$BACKUP_DIR";
  else
    echo "No se encontraron respaldos en: $BACKUP_DIR";
  fi
  exit 0
fi

TIMESTAMP="$1"
if [ ! -d "$BACKUP_DIR/$TIMESTAMP" ]; then
  echo "Marca de tiempo del respaldo no encontrada: $TIMESTAMP" >&2
  exit 2
fi

# support help
if [ "$TIMESTAMP" = "-h" ] || [ "$TIMESTAMP" = "--help" ]; then
  usage
  exit 0
fi

if [ "$#" -eq 1 ]; then
    echo "Módulos en el respaldo $TIMESTAMP:";
  ls -1 "$BACKUP_DIR/$TIMESTAMP";
  exit 0
fi

MODULE="$2"
SRC="$BACKUP_DIR/$TIMESTAMP/$MODULE"
if [ ! -d "$SRC" ]; then
  echo "Módulo no encontrado en el respaldo: $MODULE" >&2
  exit 3
fi

echo "A punto de restaurar el módulo '$MODULE' del respaldo '$TIMESTAMP' a $HOME"
read -r -p "¿Proceder y sobrescribir archivos en $HOME? [s/N]: " confirm
if [[ "${confirm,,}" != "y" && "${confirm,,}" != "yes" && "${confirm,,}" != "s" && "${confirm,,}" != "si" ]]; then
  echo "Abortado. No se realizaron cambios.";
  exit 0
fi

# usar rsync cuando esté disponible; de lo contrario, usar cp -a
if command -v rsync >/dev/null 2>&1; then
  rsync -a --backup --suffix=".restore-bak" "$SRC/" "$HOME/"
else
  # cp -a puede no soportar respaldos; advertir al usuario
  echo "rsync no encontrado; usando cp -a y sobrescribiendo archivos (sin backup automático)."
  cp -a "$SRC/" "$HOME/"
fi

echo "Restauración completada. Si usaste rsync, los archivos existentes se guardaron con sufijo '.restore-bak'"
exit 0
