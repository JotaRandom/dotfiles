#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Verifica que cada archivo en modules/ tenga su mapping en install-mappings.yml

Comprueba que todos los archivos no-dotfiles en la raiz de modulos (maxdepth 2)
esten declarados en install-mappings.yml o sean dotfiles que se dotifican automaticamente.
"""

import sys
from pathlib import Path
import re

# Configurar encoding para Windows
if sys.platform == 'win32':
    import io
    sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')
    sys.stderr = io.TextIOWrapper(sys.stderr.buffer, encoding='utf-8')

# Agregar scripts al path
sys.path.insert(0, str(Path(__file__).parent.parent.parent / 'scripts'))

from dotfiles_installer.config import DotfilesConfig


def get_mapping_keys(mappings_file: Path) -> set:
    """
    Extrae todas las claves de mapping del archivo YAML.
    
    Returns:
        Set de claves de mapping (sin sufijo de modulo)
    """
    keys = set()
    
    try:
        with open(mappings_file, 'r', encoding='utf-8') as f:
            for line in f:
                # Ignorar comentarios y listas
                line = line.strip()
                if line.startswith('#') or line.startswith('-'):
                    continue
                
                # Buscar clave antes de ':'
                if ':' in line:
                    key = line.split(':', 1)[0].strip()
                    
                    # Remover sufijo de modulo despues de '|'
                    if '|' in key:
                        key = key.split('|', 1)[0].strip()
                    
                    if key:
                        keys.add(key)
    
    except (OSError, IOError) as e:
        print(f"ERROR: No se pudo leer {mappings_file}: {e}", file=sys.stderr)
        sys.exit(1)
    
    return keys


def check_mappings():
    """Verifica que todos los archivos en modules/ tengan mapping."""
    print("="*60)
    print("Verificando mappings de archivos en modules/")
    print("="*60)
    
    # Obtener raiz del repositorio
    repo_root = Path(__file__).parent.parent.parent
    mappings_file = repo_root / 'install-mappings.yml'
    
    if not mappings_file.exists():
        print(f"ERROR: No se encontro {mappings_file}", file=sys.stderr)
        return 1
    
    # Obtener claves de mappings
    mapping_keys = get_mapping_keys(mappings_file)
    print(f"Claves de mapping encontradas: {len(mapping_keys)}")
    
    # Buscar archivos en modules/ (incluye subdirectorios)
    modules_dir = repo_root / 'modules'
    errors = 0
    files_checked = 0
    
    if not modules_dir.exists():
        print(f"ERROR: Directorio modules/ no existe", file=sys.stderr)
        return 1
    
    # Recopilar todos los archivos en modules/
    all_files = []
    for module_dir in modules_dir.iterdir():
        if not module_dir.is_dir():
            continue
        
        # Buscar archivos en el modulo y subdirectorios
        for file_path in module_dir.rglob('*'):
            if file_path.is_file():
                all_files.append(file_path)
    
    print(f"Archivos encontrados en modules/: {len(all_files)}\n")
    
    # Verificar cada archivo
    for file_path in all_files:
        try:
            rel_path = file_path.relative_to(modules_dir)
        except ValueError:
            continue
        
        files_checked += 1
        fname = file_path.name
        
        # Saltar dotfiles (se dotifican automaticamente)
        if fname.startswith('.'):
            continue
        
        # Construir ruta relativa desde modules/ para comparar
        # Ejemplo: "shell/bash/bashrc" -> necesitamos "bashrc" o "bash/bashrc"
        parts = rel_path.parts
        
        # Nombre base
        base_name = fname
        
        # Ruta relativa sin el primer nivel (modulo)
        # modules/shell/bash/bashrc -> bash/bashrc
        if len(parts) > 1:
            subpath = '/'.join(parts[1:])
        else:
            subpath = fname

        
        # Verificar si existe algun mapping
        found = False
        
        # Opcion 1: nombre base exacto
        if base_name in mapping_keys:
            found = True
        
        # Opcion 2: subpath (sin modulo principal)
        elif subpath in mapping_keys:
            found = True
        
        # Opcion 3: path completo desde modules/
        elif str(rel_path).replace('\\', '/') in mapping_keys:
            found = True
        
        # Opcion 4: claves que terminen en /nombre_base
        if not found:
            for key in mapping_keys:
                if key.endswith(f'/{base_name}'):
                    found = True
                    break
        
        if not found:
            rel_str = str(rel_path).replace('\\', '/')
            print(f"ERROR: Archivo sin mapping: {base_name} (en {rel_str})", file=sys.stderr)
            errors += 1
    
    print(f"\nArchivos verificados: {files_checked}")
    print("="*60)
    
    if errors > 0:
        print(f"X Se detectaron {errors} archivos sin mapping", file=sys.stderr)
        print(f"  Agrega entradas en install-mappings.yml", file=sys.stderr)
        print(f"  (usa 'ignore:' para README.md, etc.)", file=sys.stderr)
        print("="*60)
        return 1
    else:
        print("✓ Todos los archivos tienen mapping correcto")
        print("="*60)
        return 0


if __name__ == '__main__':
    sys.exit(check_mappings())
