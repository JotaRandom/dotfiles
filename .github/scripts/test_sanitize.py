#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Test de sanitizacion CRLF a LF

Verifica que la deteccion y conversion de finales de linea funcione correctamente,
incluyendo proteccion contra archivos binarios.
"""

import os
import sys
import tempfile
from pathlib import Path

# Configurar encoding segun OS
if sys.platform == 'win32':
    # Windows usa cp1252 por defecto en CMD
    import io
    sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')
    sys.stderr = io.TextIOWrapper(sys.stderr.buffer, encoding='utf-8')

# Agregar scripts al path
sys.path.insert(0, str(Path(__file__).parent.parent.parent / 'scripts'))

from dotfiles_installer.sanitize import sanitize_crlf_if_needed, is_binary_file


def test_crlf_conversion():
    """Verifica que archivos con CRLF se conviertan a LF."""
    print("Test 1: Conversion CRLF -> LF")
    
    with tempfile.TemporaryDirectory() as tmpdir:
        tmpdir = Path(tmpdir)
        
        # Crear archivo con CRLF
        test_file = tmpdir / '.bashrc'
        content_crlf = "#!/bin/bash\r\necho 'Hello'\r\n"
        test_file.write_bytes(content_crlf.encode('utf-8'))
        
        # Sanitizar
        result = sanitize_crlf_if_needed(test_file, tmpdir)
        
        # Verificar que se creo archivo sanitizado
        sanitized_dir = tmpdir / '.dotfiles_sanitized'
        if not sanitized_dir.exists():
            print("  X FALLO: No se creo directorio .dotfiles_sanitized")
            return False
        
        # Verificar contenido sin CRLF
        content_result = result.read_bytes()
        if b'\r\n' in content_result:
            print("  X FALLO: Archivo sanitizado aun contiene CRLF")
            return False
        
        if b'\n' not in content_result:
            print("  X FALLO: Archivo sanitizado no tiene LF")
            return False
        
        print("  > PASO: CRLF convertido a LF correctamente")
        return True


def test_no_crlf_unchanged():
    """Verifica que archivos sin CRLF no se modifiquen."""
    print("\nTest 2: Archivos sin CRLF no se modifican")
    
    with tempfile.TemporaryDirectory() as tmpdir:
        tmpdir = Path(tmpdir)
        
        # Crear archivo sin CRLF (solo LF) - usar modo binario para evitar conversion automatica
        test_file = tmpdir / '.bashrc'
        content_lf = b"#!/bin/bash\necho 'Hello'\n"
        test_file.write_bytes(content_lf)
        
        # Sanitizar
        result = sanitize_crlf_if_needed(test_file, tmpdir)
        
        # Verificar que devuelve el archivo original (mismo path)
        if str(result) != str(test_file):
            print(f"  X FALLO: Devolvio path diferente: {result} vs {test_file}")
            return False
        
        # Verificar que NO se creo directorio sanitizado
        sanitized_dir = tmpdir / '.dotfiles_sanitized'
        if sanitized_dir.exists():
            # Verificar si realmente se creo un archivo sanitizado
            sanitized_file = sanitized_dir / '.bashrc'
            if sanitized_file.exists():
                print(f"  X FALLO: Se creo archivo sanitizado innecesariamente")
                return False
        
        # Verificar que el contenido original no cambio
        content_after = test_file.read_bytes()
        if content_after != content_lf:
            print("  X FALLO: Contenido del archivo original fue modificado")
            return False
        
        print("  > PASO: Archivo sin CRLF dejado sin cambios")
        return True


def test_binary_detection():
    """Verifica que archivos binarios se detecten y salten."""
    print("\nTest 3: Deteccion de archivos binarios")
    
    with tempfile.TemporaryDirectory() as tmpdir:
        tmpdir = Path(tmpdir)
        
        # Crear archivo binario simulado (PNG)
        png_file = tmpdir / 'test.png'
        png_header = b'\x89PNG\r\n\x1a\n' + b'\x00' * 100
        png_file.write_bytes(png_header)
        
        # Verificar deteccion
        if not is_binary_file(png_file):
            print("  X FALLO: PNG no detectado como binario")
            return False
        
        # Crear archivo de texto
        text_file = tmpdir / 'test.txt'
        text_file.write_text("Hello world\n", encoding='utf-8')
        
        if is_binary_file(text_file):
            print("  X FALLO: Archivo texto detectado como binario")
            return False
        
        print("  > PASO: Binarios detectados correctamente")
        return True


def test_extension_detection():
    """Verifica deteccion por extension."""
    print("\nTest 4: Deteccion por extension")
    
    with tempfile.TemporaryDirectory() as tmpdir:
        tmpdir = Path(tmpdir)
        
        # Extensiones que deben detectarse como binarias
        binary_exts = ['.png', '.jpg', '.pdf', '.exe', '.zip']
        
        for ext in binary_exts:
            test_file = tmpdir / f'test{ext}'
            test_file.write_bytes(b'fake content')
            
            if not is_binary_file(test_file):
                print(f"  X FALLO: {ext} no detectado como binario")
                return False
        
        print("  > PASO: Extensiones binarias detectadas")
        return True


def test_preserve_executable():
    """Verifica que permisos de ejecucion se preserven."""
    print("\nTest 5: Preservacion de permisos de ejecucion")
    
    # Solo en Unix
    if os.name != 'posix':
        print("  - SALTADO: Test solo para Unix/Linux")
        return True
    
    with tempfile.TemporaryDirectory() as tmpdir:
        tmpdir = Path(tmpdir)
        
        # Crear script ejecutable con CRLF
        script = tmpdir / '.bashrc'
        script.write_bytes(b'#!/bin/bash\r\necho test\r\n')
        script.chmod(0o755)
        
        # Sanitizar
        result = sanitize_crlf_if_needed(script, tmpdir)
        
        # Verificar que es ejecutable
        if not os.access(result, os.X_OK):
            print("  X FALLO: Permisos de ejecucion no preservados")
            return False
        
        print("  > PASO: Permisos de ejecucion preservados")
        return True


def main():
    """Ejecutar todos los tests."""
    print("="*60)
    print("Tests de Sanitizacion CRLF -> LF")
    print("="*60)
    
    tests = [
        test_crlf_conversion,
        test_no_crlf_unchanged,
        test_binary_detection,
        test_extension_detection,
        test_preserve_executable,
    ]
    
    passed = 0
    failed = 0
    
    for test in tests:
        try:
            if test():
                passed += 1
            else:
                failed += 1
        except Exception as e:
            print(f"  X ERROR: {e}")
            failed += 1
    
    print("\n" + "="*60)
    print(f"Resultados: {passed} pasados, {failed} fallados")
    print("="*60)
    
    return 0 if failed == 0 else 1


if __name__ == '__main__':
    sys.exit(main())
