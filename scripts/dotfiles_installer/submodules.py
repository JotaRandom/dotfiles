#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Actualización de submódulos git del repositorio.

Maneja actualización de submódulos en distros/PKGBUILD/ (paquetes de Arch)
y submódulos del repositorio principal.
"""

import subprocess
import sys
import shutil
from pathlib import Path
from typing import Optional


def is_git_available() -> bool:
    """Verifica si git está instalado en el sistema."""
    return shutil.which('git') is not None


def run_git_command(cmd: list, cwd: Optional[Path] = None, check: bool = True) -> subprocess.CompletedProcess:
    """
    Ejecuta un comando git.
    
    Args:
        cmd: Comando git como lista
        cwd: Directorio donde ejecutar
        check: Si True, lanza excepción en error
    
    Returns:
        CompletedProcess con resultado
    """
    try:
        result = subprocess.run(
            cmd,
            cwd=cwd,
            capture_output=True,
            text=True,
            check=check
        )
        return result
    except subprocess.CalledProcessError as e:
        if check:
            print(f"ERROR ejecutando: {' '.join(cmd)}", file=sys.stderr)
            if e.stderr:
                print(f"  {e.stderr.strip()}", file=sys.stderr)
            raise
        return e


def is_git_repo(path: Path) -> bool:
    """Verifica si un directorio es un repositorio git."""
    # Verificar si tiene .git
    if (path / '.git').exists():
        return True
    
    # Verificar con git
    result = run_git_command(
        ['git', 'rev-parse', '--is-inside-work-tree'],
        cwd=path,
        check=False
    )
    return result.returncode == 0


def update_submodule(path: Path, repo_root: Optional[Path] = None, auto_commit: bool = True) -> bool:
    """
    Actualiza un submódulo git.
    
    Args:
        path: Ruta al submódulo
        repo_root: Raíz del repositorio principal
        auto_commit: Si True, hace git add automáticamente
    
    Returns:
        True si se actualizó exitosamente
    """
    if not is_git_available():
        print("  [!] Git no está disponible en el sistema", file=sys.stderr)
        return False
        
    name = path.name
    print(f"  Actualizando {name}...")
    
    try:
        # Fetch
        run_git_command(['git', 'fetch', '--all'], cwd=path)
        
        # Pull con fast-forward only, si falla intentar con merge
        result = run_git_command(
            ['git', 'pull', '--ff-only'],
            cwd=path,
            check=False
        )
        
        if result.returncode != 0:
            print(f"    Fast-forward falló, intentando merge...")
            run_git_command(['git', 'pull', '--no-edit'], cwd=path)
        
        # Agregar al índice del repo padre si se solicitó
        if auto_commit:
            # Si no se proporciona repo_root, intentar detectarlo de forma robusta
            if not repo_root:
                # El script está en scripts/dotfiles_installer/submodules.py
                # El repo_root es 2 niveles arriba de scripts/
                repo_root = Path(__file__).resolve().parent.parent.parent
            
            if repo_root.exists() and is_git_repo(repo_root):
                try:
                    relative_path = path.relative_to(repo_root)
                    run_git_command(['git', 'add', str(relative_path)], cwd=repo_root)
                except ValueError:
                    # Si path no es relativo a repo_root, saltar add
                    print(f"    [!] Saltando git add: {path} no está dentro de repo_root")
        
        print(f"    [OK] {name} actualizado")
        return True
        
    except subprocess.CalledProcessError as e:
        print(f"    [X] Error actualizando {name}: {e}", file=sys.stderr)
        return False


def update_submodules_in_dir(target_dir: Path, repo_root: Optional[Path] = None, auto_commit: bool = True) -> int:
    """
    Actualiza todos los submódulos en un directorio.
    
    Args:
        target_dir: Directorio que contiene submódulos
        repo_root: Raíz del repositorio principal
        auto_commit: Si True, hace commit automático de cambios
    
    Returns:
        Número de submódulos actualizados
    """
    if not is_git_available():
        print("ERROR: Git no está disponible", file=sys.stderr)
        return 0
        
    if not target_dir.exists():
        print(f"ERROR: Directorio {target_dir} no existe", file=sys.stderr)
        return 0
    
    if not target_dir.is_dir():
        print(f"ERROR: {target_dir} no es un directorio", file=sys.stderr)
        return 0
    
    print(f"Actualizando submódulos en {target_dir}...")
    
    updated = 0
    for item in target_dir.iterdir():
        if item.is_dir() and is_git_repo(item):
            if update_submodule(item, repo_root=repo_root, auto_commit=auto_commit):
                updated += 1
    
    return updated


def update_repo_submodules(recursive: bool = False) -> int:
    """
    Actualiza submódulos del repositorio principal usando git submodule.
    
    Args:
        recursive: Si True, actualiza recursivamente
    
    Returns:
        0 si éxito, 1 si error
    """
    if not is_git_available():
        print("[X] Git no disponible", file=sys.stderr)
        return 1
        
    print("Actualizando submódulos del repositorio...")
    
    try:
        cmd = ['git', 'submodule', 'update', '--init']
        if recursive:
            cmd.append('--recursive')
        cmd.extend(['--remote', '--merge'])
        
        run_git_command(cmd)
        print("[OK] Submódulos del repositorio actualizados")
        return 0
        
    except Exception:
        print("[X] Error actualizando submódulos del repositorio", file=sys.stderr)
        return 1
