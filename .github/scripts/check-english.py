#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Verifica que no haya cadenas en ingles en comentarios o mensajes.

Escanea archivos de scripts buscando palabras comunes en ingles que indican
que el codigo no esta completamente en español.
"""

import re
import sys
from pathlib import Path

# Configurar encoding para Windows
if sys.platform == 'win32':
    import io
    sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')
    sys.stderr = io.TextIOWrapper(sys.stderr.buffer, encoding='utf-8')

# Patron de palabras/frases comunes en ingles que no deberian estar
ENGLISH_PATTERN = r'\b(failed|error|warning|success|fail|install|uninstall|remove|delete|configure|config|setup|update|upgrade|download|upload|loading|loaded|missing|found|not found|invalid|valid|already exists|does not exist)\b'

def check_file_for_english(file_path: Path) -> list:
    """
    Verifica un archivo en busca de cadenas en ingles.
    
    Args:
        file_path: Ruta al archivo a verificar
    
    Returns:
        Lista de tuplas (numero_linea, linea_contenido) con matches
    """
    errors = []
    
    try:
        with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
            for line_num, line in enumerate(f, 1):
                # Ignorar lineas que son solo codigo (sin comentarios ni strings)
                # Buscar en comentarios (#, //, ;) y strings ("", '')
                
                # Comentarios bash/python/powershell
                if '#' in line:
                    comment_part = line[line.index('#'):]
                    if re.search(ENGLISH_PATTERN, comment_part, re.IGNORECASE):
                        errors.append((line_num, line.strip()))
                        continue
                
                # Comentarios C-style
                if '//' in line:
                    comment_part = line[line.index('//'):]
                    if re.search(ENGLISH_PATTERN, comment_part, re.IGNORECASE):
                        errors.append((line_num, line.strip()))
                        continue
                
                # Strings en echo, Write-Host, print
                if any(cmd in line for cmd in ['echo ', 'Write-Host', 'print(']):
                    if re.search(ENGLISH_PATTERN, line, re.IGNORECASE):
                        errors.append((line_num, line.strip()))
    
    except (OSError, UnicodeDecodeError):
        pass  # Saltar archivos que no se pueden leer
    
    return errors


def main():
    """Escanear archivos de scripts en busca de ingles."""
    print("="*60)
    print("Verificando cadenas en ingles en scripts")
    print("="*60)
    
    # Obtener raiz del repositorio
    repo_root = Path(__file__).parent.parent.parent
    
    # Archivos a verificar
    script_patterns = [
        'scripts/**/*.sh',
        'scripts/**/*.py',
        'scripts/**/*.ps1',
        '.github/scripts/**/*.sh',
        '.github/scripts/**/*.py',
    ]
    
    total_errors = 0
    files_with_errors = 0
    
    for pattern in script_patterns:
        for file_path in repo_root.glob(pattern):
            # Saltar archivos de test
            if 'test_' in file_path.name:
                continue
            
            errors = check_file_for_english(file_path)
            if errors:
                files_with_errors += 1
                print(f"\n{file_path.relative_to(repo_root)}:")
                for line_num, line in errors[:5]:  # Mostrar maximo 5 por archivo
                    print(f"  Linea {line_num}: {line[:80]}")
                    total_errors += 1
                
                if len(errors) > 5:
                    print(f"  ... y {len(errors) - 5} errores mas")
                    total_errors += len(errors) - 5
    
    print("\n" + "="*60)
    if total_errors == 0:
        print("[OK] No se encontraron cadenas en ingles")
        print("="*60)
        return 0
    else:
        print(f"X Se encontraron {total_errors} cadenas en ingles en {files_with_errors} archivos")
        print("="*60)
        return 1


if __name__ == '__main__':
    sys.exit(main())
