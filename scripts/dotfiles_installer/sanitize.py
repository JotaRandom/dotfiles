#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Sanitización CRLF para el instalador de dotfiles.

Maneja la detección y conversión de finales de línea CRLF a LF.
Incluye protección contra archivos binarios.
"""

import os
from pathlib import Path
from typing import Optional


# Nombres base de archivos que deben verificarse para CRLF
SANITIZE_CANDIDATES = {
    '.bashrc', '.profile', '.bash_profile', '.bash_logout',
    '.zshrc', '.zprofile', '.zlogin', '.zlogout',
    '.kshrc', '.mkshrc', 
    '.cshrc', '.tcshrc',
    '.xonshrc', '.xprofile', '.xinitrc', '.xsession'
}

# Extensiones de archivos binarios que nunca deben sanitizarse
BINARY_EXTENSIONS = {
    # Imágenes
    '.png', '.jpg', '.jpeg', '.gif', '.bmp', '.ico', '.webp', '.svg',
    '.tiff', '.tif', '.psd', '.xcf',
    # Documentos binarios
    '.pdf', '.doc', '.docx', '.xls', '.xlsx', '.ppt', '.pptx',
    # Archivos comprimidos
    '.zip', '.tar', '.gz', '.bz2', '.xz', '.7z', '.rar',
    # Ejecutables y librerías
    '.exe', '.dll', '.so', '.dylib', '.bin', '.o', '.a',
    # Fuentes
    '.ttf', '.otf', '.woff', '.woff2', '.eot',
    # Multimedia
    '.mp3', '.mp4', '.avi', '.mkv', '.wav', '.flac',
    # Otros
    '.pyc', '.pyo', '.class', '.jar'
}


def is_binary_file(file_path: Path) -> bool:
    """
    Detecta si un archivo es binario verificando magic bytes.
    
    Args:
        file_path: Ruta al archivo a verificar
    
    Returns:
        True si es binario, False si es texto
    """
    # Verificar extensión primero (más rápido)
    if file_path.suffix.lower() in BINARY_EXTENSIONS:
        return True
    
    # Leer primeros bytes para detectar contenido binario
    try:
        with open(file_path, 'rb') as f:
            chunk = f.read(8192)  # Leer primeros 8KB
            
            # Si está vacío, es texto
            if not chunk:
                return False
            
            # Buscar bytes nulos (común en binarios, raro en texto)
            if b'\x00' in chunk:
                return True
            
            # Verificar magic numbers conocidos
            # PNG: 89 50 4E 47
            if chunk.startswith(b'\x89PNG'):
                return True
            # JPEG: FF D8 FF
            if chunk.startswith(b'\xFF\xD8\xFF'):
                return True
            # GIF: 47 49 46 38
            if chunk.startswith(b'GIF8'):
                return True
            # PDF: 25 50 44 46
            if chunk.startswith(b'%PDF'):
                return True
            # ZIP/DOCX/etc: 50 4B
            if chunk.startswith(b'PK'):
                return True
            
            # Heurística: contar bytes no textuales
            # Si más del 30% son no-ASCII o de control, probablemente es binario
            non_text_bytes = sum(1 for byte in chunk 
                               if byte < 0x20 and byte not in (0x09, 0x0A, 0x0D))
            if len(chunk) > 0 and (non_text_bytes / len(chunk)) > 0.3:
                return True
            
            return False
            
    except (OSError, IOError):
        # Si no podemos leer, asumimos que es binario por seguridad
        return True


def sanitize_crlf_if_needed(source_file: Path, target_dir: Path) -> Path:
    """
    Verifica si un archivo necesita sanitización CRLF y crea copia sanitizada si es necesario.
    
    Args:
        source_file: Ruta al archivo fuente a verificar
        target_dir: Directorio destino (para crear directorio sanitizado)
    
    Returns:
        Ruta al archivo que debe usarse (original o copia sanitizada)
    """
    basename = source_file.name
    
    # Solo verificar archivos en la lista de candidatos
    if basename not in SANITIZE_CANDIDATES:
        return source_file
    
    # Verificar que el archivo existe y es un archivo regular
    if not source_file.exists() or not source_file.is_file():
        return source_file
    
    # Detectar archivos binarios antes de intentar leerlos como texto
    if is_binary_file(source_file):
        print(f"  ⚠ Saltando archivo binario: {basename}")
        return source_file
    
    # Verificar CRLF
    try:
        with open(source_file, 'rb') as f:
            content = f.read()
            if b'\r\n' not in content:
                # No se encontró CRLF, usar original
                return source_file
    except (OSError, IOError):
        # No se puede leer, usar original
        return source_file
    
    # CRLF encontrado - crear copia sanitizada
    sanitized_dir = target_dir / '.dotfiles_sanitized'
    sanitized_dir.mkdir(parents=True, exist_ok=True)
    
    sanitized_path = sanitized_dir / basename
    
    try:
        # Convertir CRLF a LF - usar modo binario para control total
        with open(source_file, 'rb') as f_in:
            content_bytes = f_in.read()
        
        # Reemplazar \r\n con \n
        content_bytes = content_bytes.replace(b'\r\n', b'\n')
        
        with open(sanitized_path, 'wb') as f_out:
            f_out.write(content_bytes)
        
        # Preservar permisos de ejecución si existen
        if os.access(source_file, os.X_OK):
            os.chmod(sanitized_path, 0o755)
        
        print(f"  🔧 Sanitizado CRLF a LF: {basename}")
        return sanitized_path
    
    except (OSError, IOError) as e:
        print(f"  ⚠ Falló sanitización de {basename}: {e}")
        return source_file
