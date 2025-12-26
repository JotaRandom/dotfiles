#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Gestión de atributos de archivos (permisos de ejecución).

Detecta y establece permisos ejecutables para scripts con shebang o extensión .sh.
"""

import os
from pathlib import Path


# Archivos RC que típicamente deberían ser ejecutables
EXECUTABLE_RC_FILES = {
    '.bashrc', '.bash_profile', '.bash_login', '.bash_logout',
    '.zshrc', '.zprofile', '.zlogin', '.zlogout',
    '.profile',
    '.kshrc', '.mkshrc',
}


def has_shebang(file_path: Path) -> bool:
    """
    Verifica si un archivo tiene shebang (#!) en la primera línea.
    
    Args:
        file_path: Ruta al archivo a verificar
    
    Returns:
        True si tiene shebang, False en caso contrario
    """
    if not file_path.exists() or not file_path.is_file():
        return False
    
    try:
        with open(file_path, 'rb') as f:
            # Leer primeros bytes
            first_line = f.readline(100)  # Máximo 100 bytes
            
            # Verificar shebang
            if first_line.startswith(b'#!'):
                return True
    
    except (OSError, IOError):
        pass
    
    return False


def should_be_executable(file_path: Path) -> bool:
    """
    Determina si un archivo debería tener permisos de ejecución.
    
    Criterios:
    - Tiene shebang (#!) en primera línea
    - Extensión .sh
    - Es un archivo RC conocido (.bashrc, .zshrc, etc.)
    
    Args:
        file_path: Ruta al archivo a verificar
    
    Returns:
        True si debería ser ejecutable
    """
    if not file_path.exists() or not file_path.is_file():
        return False
    
    # Criterio 1: Tiene shebang
    if has_shebang(file_path):
        return True
    
    # Criterio 2: Extensión .sh
    if file_path.suffix.lower() == '.sh':
        return True
    
    # Criterio 3: Archivo RC conocido
    if file_path.name in EXECUTABLE_RC_FILES:
        return True
    
    return False


def fix_attributes(path: Path, recursive: bool = False, verbose: bool = False) -> bool:
    """
    Establece permisos de ejecución si el archivo lo requiere.
    
    Args:
        path: Ruta al archivo o directorio
        recursive: Si es True y path es un directorio, procesa recursivamente
        verbose: Si True, imprime mensajes
    
    Returns:
        True si se modificaron permisos, False en caso contrario
    """
    # En Windows, no-op para permisos Unix
    if os.name != 'posix':
        return False
    
    if not path.exists():
        return False

    if path.is_dir():
        if not recursive:
            return False
        
        modified = False
        for item in path.rglob('*'):
            if item.is_file():
                if fix_attributes(item, recursive=False, verbose=verbose):
                    modified = True
        return modified
    
    if not path.is_file():
        return False
    
    # Verificar si debe ser ejecutable
    if not should_be_executable(path):
        return False
    
    # Verificar si ya es ejecutable
    if os.access(path, os.X_OK):
        return False
    
    # Establecer permisos ejecutables
    try:
        # Agregar permisos de ejecución: rwxr-xr-x (0o755)
        os.chmod(path, 0o755)
        if verbose:
            print(f"  ✓ Permisos ejecutables agregados: {path.name}")
        return True
    except (OSError, IOError) as e:
        if verbose:
            print(f"  ⚠ No se pudieron establecer permisos en {path.name}: {e}")
        return False
