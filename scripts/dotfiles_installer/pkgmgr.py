#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Package manager utilities for dotfiles installer.

Proporciona funciones compartidas para detectar distribuciones,
package managers, y herramientas de escalado de privilegios.
"""

import subprocess
import sys
import shutil
from pathlib import Path
from typing import Dict, List, Optional, Tuple


def detect_distro() -> Optional[str]:
    """
    Detecta la distribución o sistema operativo actual.
    
    Returns:
        'arch', 'debian', 'fedora', 'opensuse', 'alpine', 'gentoo', 
        'macos', 'freebsd', o None si no se puede detectar
    """
    # Intentar leer /etc/os-release
    try:
        with open('/etc/os-release', 'r') as f:
            content = f.read().lower()
            
            if 'arch' in content or 'manjaro' in content or 'endeavour' in content:
                return 'arch'
            elif 'debian' in content or 'ubuntu' in content or 'mint' in content or 'pop' in content:
                return 'debian'
            elif 'fedora' in content or 'rhel' in content or 'centos' in content or 'rocky' in content:
                return 'fedora'
            elif 'opensuse' in content or 'suse' in content:
                return 'opensuse'
            elif 'alpine' in content:
                return 'alpine'
            elif 'gentoo' in content:
                return 'gentoo'
    except FileNotFoundError:
        pass
    
    # Detección por plataforma (No Linux)
    import platform
    system = platform.system().lower()
    
    if system == 'darwin':
        return 'macos'
    elif 'freebsd' in system:
        return 'freebsd'
    
    # Fallback: verificar package managers
    if which('pacman'):
        return 'arch'
    elif which('apt'):
        return 'debian'
    elif which('dnf'):
        return 'fedora'
    elif which('zypper'):
        return 'opensuse'
    elif which('apk'):
        return 'alpine'
    elif which('emerge'):
        return 'gentoo'
    elif which('pkg') and system != 'darwin': # Evitar confundir con otros en mac
        return 'freebsd'
    elif which('brew'):
        return 'macos'
        
    return None


def which(command: str) -> bool:
    """
    Verifica si un comando existe en PATH.
    
    Args:
        command: Nombre del comando a buscar
    
    Returns:
        True si el comando existe, False en caso contrario
    """
    return shutil.which(command) is not None


def get_privilege_tools() -> List[str]:
    """
    Detecta herramientas de escalado de privilegios disponibles.
    
    Returns:
        Lista de herramientas disponibles en orden de preferencia
    """
    tools = []
    for tool in ['doas', 'sudo-rs', 'sudo', 'run0']:
        if which(tool):
            tools.append(tool)
    return tools


def get_package_manager_info(distro: str) -> Optional[Dict[str, any]]:
    """
    Obtiene información del package manager para una distribución.
    
    Args:
        distro: Nombre de la distribución
    
    Returns:
        Diccionario con información del package manager o None
    """
    package_managers = {
        'arch': {
            'command': 'pacman',
            'install_args': ['-S', '--noconfirm', '--needed'],
            'update_args': ['-Sy'],
            'search_args': ['-Ss'],
        },
        'debian': {
            'command': 'apt',
            'install_args': ['install', '-y'],
            'update_args': ['update'],
            'search_args': ['search'],
        },
        'fedora': {
            'command': 'dnf',
            'install_args': ['install', '-y'],
            'update_args': ['check-update'],
            'search_args': ['search'],
        },
        'opensuse': {
            'command': 'zypper',
            'install_args': ['install', '-y'],
            'update_args': ['refresh'],
            'search_args': ['search'],
        },
        'alpine': {
            'command': 'apk',
            'install_args': ['add'],
            'update_args': ['update'],
            'search_args': ['search'],
        },
        'gentoo': {
            'command': 'emerge',
            'install_args': ['--ask=n'],
            'update_args': ['--sync'],
            'search_args': ['--search'],
        },
        'freebsd': {
            'command': 'pkg',
            'install_args': ['install', '-y'],
            'update_args': ['update'],
            'search_args': ['search'],
        },
        'macos': {
            'command': 'brew',
            'install_args': ['install'],
            'update_args': ['update'],
            'search_args': ['search'],
        },
    }
    
    return package_managers.get(distro)


def install_package(package: str, distro: str, interactive: bool = True) -> bool:
    """
    Instala un paquete usando el package manager apropiado.
    
    Args:
        package: Nombre del paquete a instalar
        distro: Distribución ('arch', 'debian', 'fedora', 'opensuse')
        interactive: Si True, pregunta antes de instalar
    
    Returns:
        True si se instaló exitosamente, False en caso contrario
    """
    # Obtener información del package manager
    pm_info = get_package_manager_info(distro)
    if not pm_info:
        print(f"  [!] Distribución no soportada: {distro}")
        return False
    
    # Verificar que el package manager existe
    if not which(pm_info['command']):
        print(f"  [!] Package manager no encontrado: {pm_info['command']}")
        return False
    
    # Herramientas de privilegios
    priv_tools = ['sudo', 'doas', 'pkexec']
    priv_tools = [pt for pt in priv_tools if which(pt)]
    
    if not priv_tools:
        print(f"  [!] No se encontró herramienta de privilegios (sudo, doas, etc.)")
        return False
    
    # Preguntar si instalar (si es interactivo)
    if interactive and sys.stdin.isatty():
        response = input(f"  ¿Instalar {package}? (s/n): ").strip().lower()
        if response not in ('s', 'si', 'y', 'yes'):
            print(f"  Omitiendo instalación de {package}")
            return False
    
    # Construir comando de instalación
    install_cmd = [pm_info['command']] + pm_info['install_args'] + [package]
    
    # Homebrew (macOS) NO debe usar sudo/privilegios
    if distro == 'macos':
        try:
            print(f"  -> Instalando {package} con {pm_info['command']}...")
            subprocess.check_call(install_cmd)
            print(f"  [OK] {package} instalado exitosamente")
            return True
        except subprocess.CalledProcessError:
            print(f"  [X] No se pudo instalar {package}")
            return False
            
    # Intentar con cada herramienta de privilegios
    for priv_tool in priv_tools:
        try:
            print(f"  -> Instalando {package} con {priv_tool}...")
            subprocess.check_call([priv_tool] + install_cmd)
            print(f"  [OK] {package} instalado exitosamente")
            return True
        except subprocess.CalledProcessError:
            continue
    
    print(f"  [X] No se pudo instalar {package}")
    return False


def install_packages(packages: List[str], distro: str, interactive: bool = True) -> Tuple[List[str], List[str]]:
    """
    Instala múltiples paquetes.
    
    Args:
        packages: Lista de nombres de paquetes
        distro: Distribución
        interactive: Si True, pregunta antes de instalar
    
    Returns:
        Tupla de (paquetes_instalados, paquetes_fallidos)
    """
    installed = []
    failed = []
    
    for package in packages:
        if install_package(package, distro, interactive):
            installed.append(package)
        else:
            failed.append(package)
    
    return (installed, failed)


def is_package_installed(package: str, distro: str) -> bool:
    """
    Verifica si un paquete está instalado.
    
    Args:
        package: Nombre del paquete
        distro: Distribución
    
    Returns:
        True si está instalado, False en caso contrario
    """
    pm_info = get_package_manager_info(distro)
    if not pm_info:
        return False
    
    check_commands = {
        'arch': ['pacman', '-Q', package],
        'debian': ['dpkg-query', '-W', package], # Simplificado ya que arriba hay lógica especial para Debian
        'fedora': ['rpm', '-q', package],
        'opensuse': ['rpm', '-q', package],
        'alpine': ['apk', 'info', '-e', package],
        'gentoo': ['qlist', '-I', package],
        'freebsd': ['pkg', 'info', package],
        'macos': ['brew', 'list', package],
    }
    
    cmd = check_commands.get(distro)
    if not cmd:
        return False
    
    try:
        if distro == 'debian':
            # En Debian/Ubuntu, dpkg -l puede mostrar 'rc' (remover configuración) para paquetes no instalados.
            # Verificamos que el estado empiece por 'ii' (installed).
            result = subprocess.run(['dpkg-query', '-W', '-f=${Status}', package], 
                                  capture_output=True, text=True, check=False)
            return 'install ok installed' in result.stdout
        else:
            subprocess.check_call(cmd, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
            return True
    except subprocess.CalledProcessError:
        return False
