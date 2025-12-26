#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Gestión de backups de dotfiles.

Permite listar, restaurar y limpiar backups creados por install.py.
"""

import sys
import json
import shutil
from pathlib import Path
from datetime import datetime
from typing import List, Tuple, Optional

# Configurar encoding para Windows
if sys.platform == 'win32':
    import io
    sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')
    sys.stderr = io.TextIOWrapper(sys.stderr.buffer, encoding='utf-8')


def get_backup_dir(target_dir: Optional[Path] = None) -> Path:
    """
    Obtiene el directorio de backups.
    
    Si se proporciona target_dir y no es el home del usuario, 
    el backup se guarda dentro de ese target para mantener aislamiento.
    """
    if target_dir:
        # Si el target es el home, usar la ruta estándar
        if target_dir.resolve() == Path.home().resolve():
            return Path.home() / '.dotfiles_backup'
        # Si es un target personalizado, guardar backups allí mismo
        return target_dir / '.dotfiles_backup'
        
    return Path.home() / '.dotfiles_backup'


def list_backups(target_dir: Optional[Path] = None, verbose: bool = False) -> List[Tuple[str, Optional[dict]]]:
    """
    Lista todos los backups disponibles.
    
    Args:
        target_dir: Directorio target opcional
        verbose: Si True, muestra información detallada
    
    Returns:
        Lista de tuplas (timestamp, metadata)
    """
    backup_dir = get_backup_dir(target_dir)
    
    if not backup_dir.exists():
        if verbose:
            print("No se encontraron backups")
        return []
    
    # Buscar directorios de backup (formato timestamp)
    backups = []
    for item in backup_dir.iterdir():
        if item.is_dir():
            # Verificar si tiene metadata
            metadata_file = item / 'metadata.json'
            if metadata_file.exists():
                try:
                    with open(metadata_file, 'r', encoding='utf-8') as f:
                        metadata = json.load(f)
                    backups.append((item.name, metadata))
                except:
                    backups.append((item.name, None))
            else:
                backups.append((item.name, None))
    
    if not backups:
        if verbose:
            print("No se encontraron backups")
        return []
    
    # Ordenar por timestamp (más reciente primero)
    backups.sort(reverse=True)
    
    if verbose:
        print("="*60)
        print("Backups Disponibles")
        print("="*60)
        
        for timestamp, metadata in backups:
            print(f"\nTimestamp: {timestamp}")
            if metadata:
                print(f"  Fecha: {metadata.get('timestamp', 'N/A')}")
                modules = metadata.get('modules_installed', [])
                if modules:
                    print(f"  Modulos: {', '.join(modules)}")
                files_count = len(metadata.get('files_backed_up', []))
                print(f"  Archivos: {files_count}")
            else:
                print("  (sin metadata)")
        
        print("\n" + "="*60)
        print(f"Total: {len(backups)} backup(s)")
    
    return backups


def restore_backup(timestamp: str, target_dir: Optional[Path] = None, dry_run: bool = False) -> int:
    """
    Restaura un backup específico.
    
    Args:
        timestamp: Timestamp del backup a restaurar
        target_dir: Directorio target opcional
        dry_run: Si True, solo muestra qué se haría
    
    Returns:
        0 si éxito, 1 si error
    """
    backup_base = get_backup_dir(target_dir)
    backup_dir = backup_base / timestamp
    
    if not backup_dir.exists():
        print(f"ERROR: Backup '{timestamp}' no encontrado", file=sys.stderr)
        return 1
    
    # Leer metadata
    metadata_file = backup_dir / 'metadata.json'
    if metadata_file.exists():
        with open(metadata_file, 'r', encoding='utf-8') as f:
            metadata = json.load(f)
        
        print(f"Restaurando backup de: {metadata.get('timestamp', timestamp)}")
        modules = metadata.get('modules_installed', [])
        if modules:
            print(f"Modulos: {', '.join(modules)}")
        
        files = metadata.get('files_backed_up', [])
    else:
        print(f"Restaurando backup: {timestamp} (sin metadata)")
        # Buscar archivos manualmente
        files = []
        for item in backup_dir.iterdir():
            if item.is_file() and item.name != 'metadata.json':
                files.append({
                    'original': str(Path.home() / item.name),
                    'backup': item.name
                })
    
    if not files:
        print("No hay archivos para restaurar")
        return 0
    
    print(f"\nArchivos a restaurar: {len(files)}")
    
    restored = 0
    errors = 0
    
    for file_info in files:
        original_path = Path(file_info['original'])
        backup_file = backup_dir / file_info['backup']
        
        if not backup_file.exists():
            print(f"  X Backup no encontrado: {file_info['backup']}")
            errors += 1
            continue
        
        if dry_run:
            print(f"  [DRY-RUN] Restauraria: {original_path}")
            restored += 1
        else:
            try:
                # Crear directorio padre si no existe
                original_path.parent.mkdir(parents=True, exist_ok=True)
                
                # Manejar restauración de directorios
                is_dir = file_info.get('is_dir', False)
                
                if is_dir:
                    if original_path.exists():
                         if original_path.is_dir() and not original_path.is_symlink():
                             shutil.rmtree(original_path)
                         else:
                             original_path.unlink()
                    shutil.copytree(backup_file, original_path)
                    print(f"  [OK] Restaurado (dir): {original_path.name}")
                else:
                    # Copiar backup al original
                    shutil.copy2(backup_file, original_path)
                    print(f"  [OK] Restaurado: {original_path.name}")
                
                restored += 1
            except Exception as e:
                print(f"  [X] Error restaurando {original_path.name}: {e}")
                errors += 1
    
    print(f"\nResultado: {restored} restaurados, {errors} errores")
    return 0 if errors == 0 else 1


def clean_old_backups(keep: int = 5, target_dir: Optional[Path] = None, dry_run: bool = False) -> int:
    """
    Limpia backups antiguos, manteniendo solo los más recientes.
    
    Args:
        keep: Número de backups más recientes a mantener
        target_dir: Directorio target opcional
        dry_run: Si True, solo muestra qué se eliminaría
    
    Returns:
        Número de backups eliminados
    """
    backups = list_backups(target_dir=target_dir, verbose=False)
    
    if len(backups) <= keep:
        print(f"Solo hay {len(backups)} backup(s), manteniendo todos (límite: {keep})")
        return 0
    
    backups_to_delete = backups[keep:]
    
    print(f"Backups a eliminar: {len(backups_to_delete)}")
    print(f"Backups a mantener: {keep} (más recientes)")
    
    deleted = 0
    for timestamp, metadata in backups_to_delete:
        backup_path = get_backup_dir() / timestamp
        
        if dry_run:
            print(f"  [DRY-RUN] Eliminaria: {timestamp}")
            deleted += 1
        else:
            try:
                shutil.rmtree(backup_path)
                print(f"  [CL] Eliminado: {timestamp}")
                deleted += 1
            except Exception as e:
                print(f"  [X] Error eliminando {timestamp}: {e}")
    
    print(f"\nEliminados: {deleted} backup(s)")
    return deleted


def main() -> int:
    """Punto de entrada principal."""
    import argparse
    
    parser = argparse.ArgumentParser(
        description='Restaurar backups de dotfiles',
        epilog='Los backups se almacenan en ~/.dotfiles_backup/'
    )
    parser.add_argument(
        '--list',
        action='store_true',
        help='Listar backups disponibles'
    )
    parser.add_argument(
        '--timestamp',
        help='Timestamp del backup a restaurar'
    )
    parser.add_argument(
        '--latest',
        action='store_true',
        help='Restaurar el backup mas reciente'
    )
    parser.add_argument(
        '--clean-old',
        type=int,
        metavar='N',
        help='Eliminar backups antiguos, manteniendo solo los N mas recientes'
    )
    parser.add_argument(
        '--dry-run',
        action='store_true',
        help='Mostrar que se haria sin hacer cambios'
    )
    
    args = parser.parse_args()
    
    # Comando: listar backups
    if args.list:
        list_backups(verbose=True)
        return 0
    
    # Comando: limpiar backups antiguos
    if args.clean_old is not None:
        if args.clean_old < 0:
            print("ERROR: El número de backups a mantener debe ser >= 0", file=sys.stderr)
            return 1
        clean_old_backups(keep=args.clean_old, dry_run=args.dry_run)
        return 0
    
    # Comando: restaurar último backup
    if args.latest:
        backup_dir = get_backup_dir()
        if not backup_dir.exists():
            print("ERROR: No hay backups disponibles", file=sys.stderr)
            return 1
        
        # Encontrar el mas reciente
        backups = sorted([d.name for d in backup_dir.iterdir() if d.is_dir()], reverse=True)
        if not backups:
            print("ERROR: No hay backups disponibles", file=sys.stderr)
            return 1
        
        timestamp = backups[0]
        print(f"Restaurando backup mas reciente: {timestamp}\n")
        return restore_backup(timestamp, args.dry_run)
    
    # Comando: restaurar backup específico
    if args.timestamp:
        return restore_backup(args.timestamp, args.dry_run)
    
    # Sin argumentos, mostrar ayuda
    parser.print_help()
    return 0


if __name__ == '__main__':
    sys.exit(main())
