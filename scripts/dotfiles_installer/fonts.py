#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Font verification and installation for dotfiles.

Verifica que las fuentes necesarias estén instaladas y ofrece instalarlas
según el sistema operativo y package manager disponible.
"""

import subprocess
import sys
from pathlib import Path
from typing import Dict, List, Optional, Tuple

try:
    from .pkgmgr import detect_distro, install_package, which
except ImportError:
    # Fallback para ejecución standalone
    from pkgmgr import detect_distro, install_package, which


# Mapeo de fuentes a paquetes por distribución
FONT_PACKAGES = {
    'arch': {
        'DejaVu Sans Mono': 'ttf-dejavu',
        'Liberation Mono': 'ttf-liberation',
        'Noto Sans Mono': 'noto-fonts',
        'Terminus': 'terminus-font',
    },
    'debian': {
        'DejaVu Sans Mono': 'fonts-dejavu',
        'Liberation Mono': 'fonts-liberation',
        'Noto Sans Mono': 'fonts-noto',
        'Terminus': 'xfonts-terminus',
    },
    'fedora': {
        'DejaVu Sans Mono': 'dejavu-sans-mono-fonts',
        'Liberation Mono': 'liberation-mono-fonts',
        'Noto Sans Mono': 'google-noto-sans-mono-fonts',
        'Terminus': 'terminus-fonts',
    },
    'opensuse': {
        'DejaVu Sans Mono': 'dejavu-fonts',
        'Liberation Mono': 'liberation-fonts',
        'Noto Sans Mono': 'noto-sans-mono-fonts',
        'Terminus': 'terminus-bitmap-fonts',
    },
}

# Fuentes requeridas por los dotfiles
REQUIRED_FONTS = [
    'DejaVu Sans Mono',  # Principal para terminales y editores
]

# Fuentes opcionales pero recomendadas
OPTIONAL_FONTS = [
    'Liberation Mono',   # Fallback compatible con Courier New
    'Noto Sans Mono',    # Fallback con buen soporte Unicode
]


def is_font_installed(font_name: str) -> bool:
    """
    Verifica si una fuente está instalada usando fc-list.
    
    Args:
        font_name: Nombre de la fuente (ej: "DejaVu Sans Mono")
    
    Returns:
        True si la fuente está instalada, False en caso contrario
    """
    try:
        result = subprocess.run(
            ['fc-list', ':', 'family'],
            capture_output=True,
            text=True,
            check=True
        )
        
        # fc-list devuelve una línea por fuente instalada
        installed_fonts = result.stdout.lower()
        return font_name.lower() in installed_fonts
    
    except (subprocess.CalledProcessError, FileNotFoundError):
        # fc-list no disponible o falló
        return False


def get_package_for_font(font_name: str, distro: str) -> Optional[str]:
    """
    Obtiene el nombre del paquete para una fuente en una distribución.
    
    Args:
        font_name: Nombre de la fuente
        distro: Distribución ('arch', 'debian', 'fedora', 'opensuse')
    
    Returns:
        Nombre del paquete o None si no se conoce
    """
    return FONT_PACKAGES.get(distro, {}).get(font_name)


def rebuild_font_cache() -> bool:
    """
    Reconstruye la caché de fuentes con fc-cache.
    
    Returns:
        True si se reconstruyó exitosamente, False en caso contrario
    """
    try:
        print("  -> Reconstruyendo caché de fuentes...")
        subprocess.check_call(['fc-cache', '-fv'], 
                            stdout=subprocess.DEVNULL,
                            stderr=subprocess.DEVNULL)
        print("  [OK] Caché de fuentes reconstruida")
        return True
    except (subprocess.CalledProcessError, FileNotFoundError):
        print("  [!] No se pudo reconstruir la caché de fuentes")
        return False


def check_and_install_fonts(interactive: bool = True, 
                            install_optional: bool = False) -> Tuple[List[str], List[str]]:
    """
    Verifica fuentes requeridas y opcionalmente las instala.
    
    Args:
        interactive: Si True, pregunta antes de instalar
        install_optional: Si True, también verifica fuentes opcionales
    
    Returns:
        Tupla de (fuentes_instaladas, fuentes_faltantes)
    """
    print("\n" + "="*60)
    print("Verificación de Fuentes")
    print("="*60)
    
    # Detectar distribución
    distro = detect_distro()
    if not distro:
        print("[!] No se pudo detectar la distribución Linux")
        print("  Las fuentes deben instalarse manualmente")
        return ([], REQUIRED_FONTS)
    
    print(f"Distribución detectada: {distro}")
    
    # Verificar fontconfig
    if not which('fc-list'):
        print("[!] fontconfig (fc-list) no está instalado")
        print("  No se pueden verificar fuentes automáticamente")
        return ([], REQUIRED_FONTS)
    
    fonts_to_check = REQUIRED_FONTS.copy()
    if install_optional:
        fonts_to_check.extend(OPTIONAL_FONTS)
    
    installed = []
    missing = []
    newly_installed = []
    
    # Verificar cada fuente
    for font in fonts_to_check:
        is_required = font in REQUIRED_FONTS
        status = "requerida" if is_required else "opcional"
        
        if is_font_installed(font):
            print(f"[OK] {font} ({status}): instalada")
            installed.append(font)
        else:
            print(f"[X] {font} ({status}): NO instalada")
            missing.append(font)
            
            # Intentar instalar si es requerida
            if is_required:
                package = get_package_for_font(font, distro)
                if not package:
                    print(f"  [!] No se conoce el paquete para {font} en {distro}")
                    continue
                
                # Instalar usando la función compartida
                if install_package(package, distro, interactive=interactive):
                    newly_installed.append(font)
                    installed.append(font)
                    missing.remove(font)
    
    # Reconstruir caché si se instaló algo
    if newly_installed:
        rebuild_font_cache()
    
    # Resumen
    print("\n" + "="*60)
    print("Resumen de Fuentes")
    print("="*60)
    print(f"[OK] Instaladas: {len(installed)}")
    if newly_installed:
        print(f"  Recién instaladas: {', '.join(newly_installed)}")
    
    if missing:
        print(f"\n[!] Faltantes: {len(missing)}")
        for font in missing:
            package = get_package_for_font(font, distro)
            if package:
                print(f"  - {font} -> instalar con: sudo pacman -S {package}")
            else:
                print(f"  - {font} -> instalar manualmente")
    
    return (installed, missing)


def main():
    """Punto de entrada para uso standalone."""
    import argparse
    
    parser = argparse.ArgumentParser(
        description='Verificar e instalar fuentes requeridas para dotfiles'
    )
    parser.add_argument(
        '--non-interactive',
        action='store_true',
        help='No preguntar antes de instalar (auto-instalar)'
    )
    parser.add_argument(
        '--optional',
        action='store_true',
        help='También verificar e instalar fuentes opcionales'
    )
    
    args = parser.parse_args()
    
    installed, missing = check_and_install_fonts(
        interactive=not args.non_interactive,
        install_optional=args.optional
    )
    
    # Exit code: 0 si todas las requeridas están, 1 si falta alguna
    return 0 if not missing else 1


if __name__ == '__main__':
    sys.exit(main())
