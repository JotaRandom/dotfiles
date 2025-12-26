#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Configuración de Git hooks personalizados.

Configura Git para usar el directorio .githooks/ y asegura que
archivos con shebang tengan el bit ejecutable en el índice de Git.
"""

import subprocess
import sys
from pathlib import Path
from typing import Optional


def is_git_repo(path: Optional[Path] = None) -> bool:
    """
    Verifica si estamos dentro de un repositorio git.
    
    Args:
        path: Directorio a verificar (default: directorio actual)
    
    Returns:
        True si estamos en un repo git
    """
    try:
        result = subprocess.run(
            ['git', 'rev-parse', '--is-inside-work-tree'],
            cwd=path,
            capture_output=True,
            check=False
        )
        return result.returncode == 0
    except FileNotFoundError:
        return False


def setup_hooks_path(hooks_dir: str = '.githooks') -> bool:
    """
    Configura Git para usar un directorio personalizado de hooks.
    
    Args:
        hooks_dir: Directorio de hooks (relativo a raíz del repo)
    
    Returns:
        True si exitoso
    """
    if not is_git_repo():
        print("ERROR: No se encuentra dentro de un repositorio Git", file=sys.stderr)
        return False
    
    try:
        subprocess.run(
            ['git', 'config', 'core.hooksPath', hooks_dir],
            check=True,
            capture_output=True
        )
        print(f"[OK] Ruta de hooks de Git configurada a '{hooks_dir}'")
        print(f"  Para revertir: git config --unset core.hooksPath")
        return True
    except subprocess.CalledProcessError as e:
        print(f"ERROR al configurar hooks path: {e}", file=sys.stderr)
        if e.stderr:
            print(f"  {e.stderr.decode('utf-8').strip()}", file=sys.stderr)
        return False


def fix_executable_permissions() -> int:
    """
    Asegura que archivos con shebang tengan bit ejecutable en índice de Git.
    
    Esto es idempotente - se puede ejecutar múltiples veces sin problemas.
    
    Returns:
        Número de archivos actualizados
    """
    if not is_git_repo():
        print("ERROR: No se encuentra dentro de un repositorio Git", file=sys.stderr)
        return 0
    
    print("\nAsegurando permisos ejecutables en archivos con shebang...")
    
    # Obtener lista de archivos en el índice
    try:
        result = subprocess.run(
            ['git', 'ls-files', '-z'],
            capture_output=True,
            check=True,
            text=False  # Necesitamos bytes para split correcto
        )
    except subprocess.CalledProcessError as e:
        print(f"ERROR al listar archivos de git: {e}", file=sys.stderr)
        return 0
    
    # Split por null byte
    files = result.stdout.decode('utf-8').split('\0')
    files = [f for f in files if f]  # Remover vacíos
    
    updated = 0
    errors = 0
    
    for file_path_str in files:
        file_path = Path(file_path_str)
        
        # Verificar que el archivo existe
        if not file_path.exists():
            continue
        
        if not file_path.is_file():
            continue
        
        # Leer primera línea
        try:
            with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
                first_line = f.readline().strip()
        except (OSError, IOError):
            continue
        
        # Verificar si tiene shebang
        if not first_line.startswith('#!'):
            continue
        
        # Actualizar permisos en índice de Git
        try:
            subprocess.run(
                ['git', 'update-index', '--chmod=+x', str(file_path)],
                capture_output=True,
                check=True
            )
            updated += 1
            print(f"  [OK] {file_path}")
        except subprocess.CalledProcessError:
            # Pueden fallar algunos (ej: archivos ya con +x), no es crítico
            errors += 1
    
    if updated > 0:
        print(f"\n[OK] {updated} archivo(s) con shebang actualizado(s)")
    else:
        print("\n[OK] No se necesitaron actualizaciones")
    
    if errors > 0 and errors < len(files):
        print(f"  (algunos archivos ya tenían permisos correctos)")
    
    return updated


def setup_githooks(hooks_dir: str = '.githooks', fix_permissions: bool = True) -> int:
    """
    Configura git hooks completamente.
    
    Args:
        hooks_dir: Directorio de hooks
        fix_permissions: Si True, también arregla permisos ejecutables
    
    Returns:
        0 si exitoso, 1 si error
    """
    # Verificar que estamos en un repo
    if not is_git_repo():
        print("ERROR: No se encuentra dentro de un repositorio Git", file=sys.stderr)
        return 1
    
    # Configurar hooks path
    if not setup_hooks_path(hooks_dir):
        return 1
    
    # Arreglar permisos si se solicitó
    if fix_permissions:
        fix_executable_permissions()
    
    print("\n" + "="*60)
    print("[OK] Configuración de Git hooks completada")
    print("="*60)
    
    return 0


def disable_githooks() -> int:
    """
    Desactiva hooks personalizados y revierte a configuración por defecto de Git.
    
    Returns:
        0 si exitoso, 1 si error
    """
    if not is_git_repo():
        print("ERROR: No se encuentra dentro de un repositorio Git", file=sys.stderr)
        return 1
    
    try:
        subprocess.run(
            ['git', 'config', '--unset', 'core.hooksPath'],
            check=True,
            capture_output=True
        )
        print("[OK] Hooks personalizados desactivados")
        print("  Git usará .git/hooks/ (configuración por defecto)")
        return 0
    except subprocess.CalledProcessError as e:
        # Si el config no existe, no es un error
        stderr_str = e.stderr.decode('utf-8', errors='ignore').lower()
        if 'not found' in stderr_str or 'no such' in stderr_str:
            print("[OK] No había hooks personalizados configurados")
            return 0
        print(f"ERROR al desactivar hooks: {e}", file=sys.stderr)
        if e.stderr:
            print(f"  {e.stderr.decode('utf-8').strip()}", file=sys.stderr)
        return 1
