#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Git LFS installation and verification for dotfiles.

Verifica que git-lfs esté instalado y ofrece instalarlo
según el sistema operativo y package manager disponible.
"""

import subprocess
import sys
from pathlib import Path
from typing import Optional

try:
    from .pkgmgr import detect_distro, install_package, which
except ImportError:
    # Fallback para ejecución standalone
    from pkgmgr import detect_distro, install_package, which


# Mapeo de paquetes git-lfs por distribución
GIT_LFS_PACKAGES = {
    'arch': 'git-lfs',
    'debian': 'git-lfs',
    'fedora': 'git-lfs',
    'opensuse': 'git-lfs',
}


def is_git_lfs_installed() -> bool:
    """
    Verifica si git-lfs está instalado.
    
    Returns:
        True si git-lfs está instalado, False en caso contrario
    """
    try:
        subprocess.check_call(['git', 'lfs', 'version'],
                            stdout=subprocess.DEVNULL, 
                            stderr=subprocess.DEVNULL)
        return True
    except (subprocess.CalledProcessError, FileNotFoundError):
        return False


def get_git_lfs_package(distro: str) -> Optional[str]:
    """
    Obtiene el nombre del paquete git-lfs para una distribución.
    
    Args:
        distro: Nombre de la distribución
    
    Returns:
        Nombre del paquete o None si no se conoce
    """
    return GIT_LFS_PACKAGES.get(distro)


def install_git_lfs_macos() -> bool:
    """
    Intenta instalar git-lfs en macOS usando Homebrew.
    
    Returns:
        True si se instaló exitosamente, False en caso contrario
    """
    if not which('brew'):
        print("  [!] Homebrew no está instalado")
        print("  Instala Homebrew desde: https://brew.sh/")
        return False
    
    try:
        print("  -> Instalando git-lfs con Homebrew...")
        subprocess.check_call(['brew', 'install', 'git-lfs'])
        print("  [OK] git-lfs instalado exitosamente")
        return True
    except subprocess.CalledProcessError:
        print("  [X] No se pudo instalar git-lfs con Homebrew")
        return False


def check_and_install_git_lfs(interactive: bool = True) -> bool:
    """
    Verifica que git-lfs esté instalado y ofrece instalarlo si falta.
    
    Args:
        interactive: Si True, pregunta antes de instalar
    
    Returns:
        True si git-lfs está disponible (ya instalado o recién instalado),
        False en caso contrario
    """
    # Verificar si ya está instalado
    if is_git_lfs_installed():
        return True
    
    print("\n[!] git-lfs no está instalado")
    print("  git-lfs es necesario para algunos submódulos con assets grandes")
    
    # Verificar si estamos en terminal interactiva
    if interactive and not sys.stdin.isatty():
        print("  Modo no interactivo detectado. Omitiendo instalación de git-lfs")
        print("  Por favor instala git-lfs manualmente más tarde")
        return False
    
    # Preguntar si instalar (si es interactivo)
    if interactive:
        response = input("  ¿Deseas intentar instalar git-lfs ahora? (s/n): ").strip().lower()
        if response not in ('s', 'si', 'y', 'yes'):
            print("  Omitiendo instalación de git-lfs")
            return False
    
    # Detectar sistema operativo
    import platform
    system = platform.system()
    
    if system == 'Darwin':  # macOS
        return install_git_lfs_macos()
    
    elif system == 'Linux':
        # Detectar distribución
        distro = detect_distro()
        if not distro:
            print("  [!] No se pudo detectar la distribución Linux")
            print("  Por favor instala git-lfs manualmente con tu package manager")
            return False
        
        # Obtener nombre del paquete
        package = get_git_lfs_package(distro)
        if not package:
            print(f"  [!] No se conoce el paquete git-lfs para {distro}")
            print("  Por favor instala git-lfs manualmente")
            return False
        
        # Instalar paquete
        return install_package(package, distro, interactive=False)
    
    elif system == 'Windows':
        print("  En Windows, descarga git-lfs desde: https://git-lfs.github.com/")
        return False
    
    else:
        print(f"  [!] Sistema operativo no soportado: {system}")
        print("  Por favor instala git-lfs manualmente")
        return False


def main():
    """Punto de entrada para uso standalone."""
    import argparse
    
    parser = argparse.ArgumentParser(
        description='Verificar e instalar git-lfs'
    )
    parser.add_argument(
        '--non-interactive',
        action='store_true',
        help='No preguntar antes de instalar (auto-instalar)'
    )
    
    args = parser.parse_args()
    
    print("="*60)
    print("Verificación de git-lfs")
    print("="*60)
    
    if is_git_lfs_installed():
        print("[OK] git-lfs ya está instalado")
        
        # Mostrar versión
        try:
            result = subprocess.run(['git', 'lfs', 'version'], 
                                  capture_output=True, text=True)
            print(f"  Versión: {result.stdout.strip()}")
        except:
            pass
        
        return 0
    
    success = check_and_install_git_lfs(interactive=not args.non_interactive)
    return 0 if success else 1


if __name__ == '__main__':
    sys.exit(main())
