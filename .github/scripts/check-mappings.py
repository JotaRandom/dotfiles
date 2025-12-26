#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Verifica que cada archivo en modules/ tenga su mapping en install-mappings.yml
"""

import sys
import os
from pathlib import Path
import yaml

# Configurar encoding para Windows
if sys.platform == 'win32':
    import io
    sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')
    sys.stderr = io.TextIOWrapper(sys.stderr.buffer, encoding='utf-8')

# Agregar scripts al path
sys.path.insert(0, str(Path(__file__).parent.parent.parent / 'scripts'))


def check_mappings():
    """Verifica que todos los archivos en modules/ tengan mapping."""
    print("="*60)
    print("Verificando mappings de archivos en modules/")
    print("="*60)
    
    repo_root = Path(__file__).parent.parent.parent
    mappings_file = repo_root / 'install-mappings.yml'
    
    if not mappings_file.exists():
        print(f"ERROR: No se encontro {mappings_file}", file=sys.stderr)
        return 1
    
    try:
        with open(mappings_file, 'r', encoding='utf-8') as f:
            mappings_data = yaml.safe_load(f)
    except Exception as e:
        print(f"ERROR: No se pudo cargar YAML {mappings_file}: {e}", file=sys.stderr)
        return 1

    mapping_keys = set(mappings_data.keys())
    # Claves base (sin |module)
    base_keys = {k.split('|')[0] if '|' in k else k for k in mapping_keys}
    
    print(f"Claves de mapping encontradas en YAML: {len(mapping_keys)}")
    
    modules_dir = repo_root / 'modules'
    errors = 0
    files_checked = 0
    
    if not modules_dir.exists():
        print(f"ERROR: Directorio modules/ no existe", file=sys.stderr)
        return 1
    
    # Recopilar todos los archivos en modules/
    for file_path in modules_dir.rglob('*'):
        if not file_path.is_file():
            continue
            
        try:
            rel_path = file_path.relative_to(modules_dir)
        except ValueError:
            continue
            
        files_checked += 1
        fname = file_path.name
        
        # Saltar dotfiles
        if fname.startswith('.'):
            continue
            
        parts = rel_path.parts
        base_name = fname
        
        # Encontrar el nombre del módulo (último directorio antes de los archivos configuración)
        # Por simplicidad, probaremos todas las partes como posibles módulos
        found = False
        
        # 1. Nombre base
        if base_name in base_keys:
            found = True
        
        # 2. Subpath (relativo a modules/)
        if not found:
            # shell/bash/bashrc
            if len(parts) > 1:
                # Probar bash/bashrc
                for i in range(len(parts)-1):
                    p = '/'.join(parts[i+1:])
                    if p in base_keys:
                        found = True
                        break
            
            # Probar path completo
            if not found:
                p_full = '/'.join(parts)
                if p_full in base_keys:
                    found = True

        # 3. Sufijo /nombre_base
        if not found:
            for k in base_keys:
                if k.endswith(f'/{base_name}'):
                    found = True
                    break
        
        # 4. Wildcards y Optimización (NUEVO)
        if not found:
            # Probar cada parte de la ruta como posible nombre de módulo para wildcard (*|module)
            for part in parts:
                if f"*|{part}" in mapping_keys:
                    found = True
                    break
            
            if not found and "*" in mapping_keys:
                 found = True

            # Verificar si algún padre tiene mapeo de directorio explícito
            if not found:
                for i in range(len(parts)):
                    p = '/'.join(parts[0:i+1])
                    if p in base_keys or f"{p}/*" in base_keys:
                        found = True
                        break
                # También probar sin categoría
                if not found and len(parts) > 1:
                    for i in range(1, len(parts)):
                        p = '/'.join(parts[1:i+1])
                        if p in base_keys or f"{p}/*" in base_keys:
                            found = True
                            break

        if not found:
            rel_str = str(rel_path).replace('\\', '/')
            # No reportar como error README o LICENSE si no tienen mapping (silencioso)
            if base_name.upper() in ['README.MD', 'README', 'LICENSE', 'LICENSE.MD']:
                continue
                
            print(f"ERROR: Archivo sin mapping: {base_name} (en {rel_str})", file=sys.stderr)
            errors += 1
            
    print(f"\nArchivos verificados: {files_checked}")
    print("="*60)
    
    if errors > 0:
        print(f"[X] Se detectaron {errors} archivos sin mapping", file=sys.stderr)
        return 1
    else:
        print("[OK] Todos los archivos tienen mapping correcto")
        return 0


if __name__ == '__main__':
    sys.exit(check_mappings())
