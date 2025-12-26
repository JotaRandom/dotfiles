#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Instalador de dotfiles en Python 3.13+

"""
Instalador de dotfiles con soporte multiplataforma.

Instala archivos de configuración desde modules/ según install-mappings.yml.
Soporta dotificación automática, XDG paths, y múltiples destinos.
"""

import argparse
import subprocess
import sys
from pathlib import Path
import os
import io

# Configurar encoding para Windows
if sys.platform == 'win32':
    sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')
    sys.stderr = io.TextIOWrapper(sys.stderr.buffer, encoding='utf-8')

# Add scripts directory to path for imports
sys.path.insert(0, str(Path(__file__).parent))


def check_and_install_pyyaml():
    """Verifica que PyYAML esté instalado, lo instala automáticamente si falta."""
    try:
        import yaml
        return True
    except (ImportError, ModuleNotFoundError):
        # Instalar automáticamente sin preguntar (como el script original)
        print("[!] PyYAML no está instalado. Instalando automáticamente...")
        try:
            subprocess.check_call([sys.executable, "-m", "pip", "install", "pyyaml"],
                                 stdout=subprocess.DEVNULL,
                                 stderr=subprocess.DEVNULL)
            import yaml
            print("[OK] PyYAML instalado exitosamente")
            return True
        except subprocess.CalledProcessError:
            print("[X] ERROR: No se pudo instalar PyYAML automáticamente")
            print("Por favor instala 'python-yaml' o 'pyyaml' manualmente.")
            sys.exit(1)


# Import git-lfs checker from module
from dotfiles_installer.gitlfs import check_and_install_git_lfs

from dotfiles_installer.config import DotfilesConfig
from dotfiles_installer.mapper import FileMapper
from dotfiles_installer.symlink import SymlinkManager
from dotfiles_installer.attributes import fix_attributes
from dotfiles_installer.sanitize import sanitize_crlf_if_needed


def install_module(module_path: Path, config: DotfilesConfig, 
                   mapper: FileMapper, symlink_mgr: SymlinkManager,
                   fix_eol: bool = False, fix_attribs: bool = False,
                   allow_backup: bool = True, dry_run: bool = False):
    """
    Instala un módulo individual creando symlinks para sus archivos.
    
    Args:
        module_path: Ruta al directorio del módulo
        config: Objeto de configuración
        mapper: Mapeador de archivos para resolución de destinos
        symlink_mgr: Gestor de symlinks para crear enlaces
        fix_eol: Si True, sanitiza CRLF a LF en archivos candidatos
        fix_attribs: Si True, establece permisos ejecutables en scripts
        allow_backup: Si True, crea backups de archivos existentes
        dry_run: Si True, solo muestra lo que se haría sin crear symlinks
    """
    if not module_path.exists() or not module_path.is_dir():
        print(f"[X] Módulo no encontrado: {module_path}")
        return
    
    module_name = module_path.name
    print(f"\n{'='*60}")
    print(f"Instalando módulo: {module_name}")
    print(f"{'='*60}")
    
    files_processed = 0
    symlinks_created = 0
    
    # --- NUEVO: Soporte para enlace a directorios completos ---
    # Si el módulo tiene un mapeo de wildcard (*), lo tratamos como un enlace de directorio
    # y evitamos iterar por sus archivos individuales.
    destinations, is_explicit, action = mapper.resolve_destination('*', module_name)
    if is_explicit and action != 'ignore' and destinations:
        print(f"  [OK] Optimización: Creando enlace de directorio para módulo {module_name}")
        for dest in destinations:
            if symlink_mgr.create_symlink(module_path, dest, module_name, 
                                         allow_backup=allow_backup,
                                         dry_run=dry_run):
                symlinks_created += 1
                if fix_attribs:
                    fix_attributes(module_path, recursive=True, verbose=True)
        
        print(f"\n[OK] Módulo '{module_name}' instalado (directorio):")
        print(f"  Symlinks creados: {symlinks_created}")
        return

    # Mantener registro de directorios que ya fueron enlazados para saltar sus contenidos
    processed_dirs = []

    for file_path in module_path.rglob('*'):
        # Saltar si el padre ya fue procesado como enlace de directorio
        if any(file_path.is_relative_to(d) for d in processed_dirs):
            continue
            
        # Obtener ruta relativa desde la raíz del módulo
        rel_path = file_path.relative_to(module_path)
        mapping_key = str(rel_path).replace('\\', '/')
        
        # Resolver destino(s) para este archivo/carpeta
        destinations, is_explicit, action = mapper.resolve_destination(mapping_key, module_name)
        
        # Manejar archivos a ignorar
        if not destinations or action == 'ignore':
            if is_explicit:
                print(f"  [OK] Ignorando: {rel_path}")
            continue
            
        # Si es un directorio y tiene mapeo explícito, lo enlazamos completo y saltamos hijos
        if file_path.is_dir() and is_explicit:
            print(f"  [OK] Creando enlace de directorio: {rel_path}")
            for dest in destinations:
                if symlink_mgr.create_symlink(file_path, dest, module_name, 
                                             allow_backup=allow_backup,
                                             dry_run=dry_run):
                    symlinks_created += 1
                    if fix_attribs:
                        fix_attributes(file_path, recursive=True, verbose=True)
            processed_dirs.append(file_path)
            continue
            
        # Saltar directorios sin mapeo explícito (sus hijos serán procesados individualmente)
        if file_path.is_dir():
            continue
        
        # Saltar README, LICENSE y documentación (solo si no se enlazó el directorio)
        if file_path.name.upper().startswith(('README', 'LICENSE')):
            continue
            
        files_processed += 1
        
        # Sanitizar CRLF solo si se solicitó con --fix-eol
        if fix_eol:
            source_to_link = sanitize_crlf_if_needed(file_path, config.target)
        else:
            source_to_link = file_path
        
        # Crear symlink(s) para cada destino
        for dest in destinations:
            if symlink_mgr.create_symlink(source_to_link, dest, module_name, 
                                         allow_backup=allow_backup,
                                         dry_run=dry_run):
                symlinks_created += 1
                
                # Establecer permisos ejecutables si se solicito
                if fix_attribs:
                    fix_attributes(source_to_link, recursive=False, verbose=True)
        
    print(f"\n[OK] Módulo '{module_name}' instalado:")
    print(f"  Archivos procesados: {files_processed}")
    print(f"  Symlinks creados: {symlinks_created}")


def main():
    """Main entry point for dotfiles installer."""
    
    # Parser principal con subcomandos
    parser = argparse.ArgumentParser(
        description='''
Instalador de dotfiles con gestión de backups integrada.

Crea symlinks de archivos de configuración desde modules/ hacia $HOME,
con backups automáticos, sanitización de archivos, y gestión completa de backups.
        '''.strip(),
        epilog='''
Ejemplos de uso:

  # Instalar TODOS los módulos (uso más común)
  python install.py install
  
  # Instalar módulos específicos
  python install.py install modules/shell/bash modules/editors/vim
  
  # Verificar fuentes requeridas
  python install.py check-fonts
  
  # Verificar git-lfs
  python install.py check-gitlfs
  
  # Listar backups disponibles
  python install.py backup-list
  
  # Restaurar el último backup
  python install.py backup-restore --latest
  
  # Limpiar backups antiguos (mantener últimos 5)
  python install.py backup-clean 5

Para ayuda: python install.py --help o python install.py help
Para ayuda de cada subcomando: python install.py <subcomando> --help
        '''.strip(),
        formatter_class=argparse.RawDescriptionHelpFormatter
    )
    
    subparsers = parser.add_subparsers(
        dest='command',
        help='Subcomandos disponibles (usa <subcomando> --help para detalles)'
    )
    
    # Subcomando: help (alias para --help)
    help_parser = subparsers.add_parser(
        'help',
        help='Mostrar ayuda general',
        description='Muestra la ayuda general del instalador'
    )
    
    # Subcomando: install (default)
    install_parser = subparsers.add_parser(
        'install',
        help='Instalar módulos creando symlinks',
        description='''
Instala módulos de dotfiles creando symlinks desde modules/ hacia $HOME.

Los archivos existentes se respaldan automáticamente en ~/.dotfiles_backup/
(deshabilitable con --no-backup). Soporta sanitización de finales de línea
y configuración automática de permisos ejecutables.
        '''.strip(),
        epilog='''
Ejemplos:

  # Instalar TODOS los módulos (sin argumentos)
  python install.py install
  
  # Instalar módulos específicos
  python install.py install modules/shell/bash modules/editors/vim
  
  # Instalar sin crear backups (testing)
  python install.py install --no-backup modules/shell/bash
  
  # Sanitizar CRLF -> LF
  python install.py install --fix-eol modules/shell/bash
  
  # Permisos ejecutables en scripts
  python install.py install --fix-attributes modules/bin
  
  # Combinar opciones
  python install.py install --fix-eol --fix-attributes --no-backup modules/shell/bash
  
  # Preview sin hacer cambios
  python install.py install --dry-run modules/shell/bash

Los archivos se mapean según install-mappings.yml
        '''.strip(),
        formatter_class=argparse.RawDescriptionHelpFormatter
    )
    install_parser.add_argument(
        'modules',
        nargs='*',
        help='Módulos a instalar (ej: modules/shell/bash). Si se omite, instala todos'
    )
    install_parser.add_argument(
        '--target',
        default=None,
        help='Directorio destino (default: $HOME). Útil para testing con directorios temporales'
    )
    install_parser.add_argument(
        '--fix-eol',
        action='store_true',
        help='Sanitizar finales de línea: CRLF -> LF en archivos de configuración (opcional)'
    )
    install_parser.add_argument(
        '--fix-attributes', '--fix-attribs', '--fix-exec',
        action='store_true',
        dest='fix_attribs',
        help='Establecer permisos ejecutables (+x) en scripts con shebang o extensión .sh (Unix)'
    )
    install_parser.add_argument(
        '--dry-run',
        action='store_true',
        help='Mostrar lo que se haría sin hacer cambios reales (preview)'
    )
    install_parser.add_argument(
        '--no-backup',
        action='store_true',
        help='NO crear backups de archivos existentes (no recomendado excepto para testing/CI)'
    )
    install_parser.add_argument(
        '--with-gtk',
        action='store_true',
        help='Incluir instalación de temas GTK (saltados por defecto)'
    )
    install_parser.add_argument(
        '--with-qt',
        action='store_true',
        help='Incluir instalación de componentes QT (saltados por defecto)'
    )
    install_parser.add_argument(
        '--with-themes',
        action='store_true',
        help='Incluir tanto GTK como QT (shorthand para --with-gtk --with-qt)'
    )
    
    # Subcomando: backup-list
    list_parser = subparsers.add_parser(
        'backup-list',
        help='Listar todos los backups disponibles',
        description='''
Lista todos los backups creados por el instalador.

Muestra timestamp, fecha, módulos instalados y número de archivos
de cada backup disponible en ~/.dotfiles_backup/
        '''.strip(),
        epilog='''
Ejemplo:

  python install.py backup-list

Salida mostrará todos los backups ordenados por fecha (más reciente primero).
        '''.strip(),
        formatter_class=argparse.RawDescriptionHelpFormatter
    )
    
    # Subcomando: backup-restore
    restore_parser = subparsers.add_parser(
        'backup-restore',
        help='Restaurar archivos desde un backup',
        description='''
Restaura archivos desde un backup específico o el más reciente.

Copia los archivos respaldados desde ~/.dotfiles_backup/ de vuelta
a sus ubicaciones originales, sobrescribiendo los archivos actuales.
        '''.strip(),
        epilog='''
Ejemplos:

  # Restaurar el backup más reciente
  python install.py backup-restore --latest
  
  # Restaurar backup específico (usa timestamp de backup-list)
  python install.py backup-restore --timestamp 2025-12-16_00-45-30
  
  # Preview: ver qué se restauraría sin hacer cambios
  python install.py backup-restore --latest --dry-run

Usa 'backup-list' primero para ver backups disponibles.
        '''.strip(),
        formatter_class=argparse.RawDescriptionHelpFormatter
    )
    restore_parser.add_argument(
        '--timestamp',
        help='Timestamp del backup a restaurar (formato: YYYY-MM-DD_HH-MM-SS)'
    )
    restore_parser.add_argument(
        '--latest',
        action='store_true',
        help='Restaurar el backup más reciente (recomendado)'
    )
    restore_parser.add_argument(
        '--dry-run',
        action='store_true',
        help='Mostrar qué se restauraría sin hacer cambios reales (preview)'
    )
    
    # Subcomando: backup-clean
    clean_parser = subparsers.add_parser(
        'backup-clean',
        help='Limpiar backups antiguos',
        description='''
Elimina backups antiguos manteniendo solo los N más recientes.

Útil para liberar espacio en disco eliminando backups viejos
mientras se preservan los más recientes como red de seguridad.
        '''.strip(),
        epilog='''
Ejemplos:

  # Mantener solo los 5 backups más recientes
  python install.py backup-clean 5
  
  # Mantener solo el último backup
  python install.py backup-clean 1
  
  # Eliminar todos los backups (mantener 0)
  python install.py backup-clean 0
  
  # Preview: ver qué se eliminaría sin hacer cambios
  python install.py backup-clean 5 --dry-run

Los backups se ordenan por timestamp y se mantienen los más recientes.
        '''.strip(),
        formatter_class=argparse.RawDescriptionHelpFormatter
    )
    clean_parser.add_argument(
        'keep',
        type=int,
        help='Número de backups más recientes a mantener (N >= 0)'
    )
    clean_parser.add_argument(
        '--dry-run',
        action='store_true',
        help='Mostrar qué se eliminaría sin hacer cambios reales (preview)'
    )
    
    # Subcomando: update-submodules
    submodules_parser = subparsers.add_parser(
        'update-submodules',
        help='Actualizar submódulos git del repositorio',
        description='''
Actualiza submódulos git del repositorio.

Por defecto actualiza submódulos en distros/PKGBUILD/ (paquetes de Arch).
También puede actualizar submódulos del repositorio principal (.gitmodules).
        '''.strip(),
        epilog='''
Ejemplos:

  # Actualizar todos los PKGBUILDs
  python install.py update-submodules
  
  # Actualizar PKGBUILD específico
  python install.py update-submodules --package google-chrome
  
  # Actualizar submódulos del repositorio principal
  python install.py update-submodules --repo
  
  # Actualizar recursivamente
  python install.py update-submodules --repo --recursive
  
  # Actualizar sin auto-commit (para revisar primero)
  python install.py update-submodules --no-commit

Los submódulos se actualizan con git fetch + pull (ff-only o merge).
        '''.strip(),
        formatter_class=argparse.RawDescriptionHelpFormatter
    )
    submodules_parser.add_argument(
        '--package',
        help='Actualizar solo este paquete en distros/PKGBUILD/'
    )
    submodules_parser.add_argument(
        '--repo',
        action='store_true',
        help='Actualizar submódulos del repositorio principal (con git submodule)'
    )
    submodules_parser.add_argument(
        '--recursive',
        action='store_true',
        help='Actualizar submódulos recursivamente (solo con --repo)'
    )
    submodules_parser.add_argument(
        '--no-commit',
        action='store_true',
        help='No hacer commit automático de cambios'
    )
    submodules_parser.add_argument(
        '--target-dir',
        type=Path,
        default=None,
        help='Directorio personalizado con submódulos (default: distros/PKGBUILD)'
    )
    
    # Subcomando: inspect-mappings
    inspect_parser = subparsers.add_parser(
        'inspect-mappings',
        help='Inspeccionar y analizar install-mappings.yml',
        description='''
Inspecciona install-mappings.yml y genera un reporte detallado.

Muestra estadísticas, distribución de mappings globales vs por módulo,
y tipos de acciones (link, ignore, etc).
        '''.strip(),
        epilog='''
Ejemplos:

  # Inspeccionar mappings (resumen)
  python install.py inspect-mappings
  
  # Ver todos los mappings (verbose)
  python install.py inspect-mappings --verbose
  
  # Guardar reporte en archivo
  python install.py inspect-mappings --output reporte.txt
  
  # Verbose + guardar
  python install.py inspect-mappings --verbose --output mappings_completo.txt

Útil para debuggear y entender la estructura de install-mappings.yml
        '''.strip(),
        formatter_class=argparse.RawDescriptionHelpFormatter
    )
    inspect_parser.add_argument(
        '--verbose', '-v',
        action='store_true',
        help='Mostrar todos los mappings (no solo resumen)'
    )
    inspect_parser.add_argument(
        '--output', '-o',
        type=Path,
        help='Guardar reporte en archivo'
    )
    
    # Subcomando: check-fonts
    fonts_parser = subparsers.add_parser(
        'check-fonts',
        help='Verificar e instalar fuentes requeridas',
        description='''
Verifica que las fuentes requeridas estén instaladas.

Si faltan fuentes, ofrece instalarlas automáticamente usando
el package manager de la distribución detectada.
        '''.strip(),
        epilog='''
Ejemplos:

  # Verificar fuentes (interactivo)
  python install.py check-fonts
  
  # Verificar e instalar automáticamente
  python install.py check-fonts --non-interactive
  
  # Incluir fuentes opcionales
  python install.py check-fonts --optional
        '''.strip(),
        formatter_class=argparse.RawDescriptionHelpFormatter
    )
    fonts_parser.add_argument(
        '--non-interactive',
        action='store_true',
        help='No preguntar antes de instalar (auto-instalar)'
    )
    fonts_parser.add_argument(
        '--optional',
        action='store_true',
        help='También verificar e instalar fuentes opcionales'
    )
    
    # Subcomando: check-gitlfs
    gitlfs_parser = subparsers.add_parser(
        'check-gitlfs',
        help='Verificar e instalar git-lfs',
        description='''
Verifica que git-lfs esté instalado.

Si no está instalado, ofrece instalarlo automáticamente usando
el package manager de la distribución detectada.
        '''.strip(),
        epilog='''
Ejemplos:

  # Verificar git-lfs (interactivo)
  python install.py check-gitlfs
  
  # Verificar e instalar automáticamente
  python install.py check-gitlfs --non-interactive
        '''.strip(),
        formatter_class=argparse.RawDescriptionHelpFormatter
    )
    gitlfs_parser.add_argument(
        '--non-interactive',
        action='store_true',
        help='No preguntar antes de instalar (auto-instalar)'
    )
    
    # Subcomando: setup-githooks
    githooks_parser = subparsers.add_parser(
        'setup-githooks',
        help='Configurar Git hooks personalizados',
        description='''
Configura Git para usar hooks personalizados en .githooks/

También asegura que todos los archivos con shebang tengan
el bit ejecutable en el índice de Git (idempotente).
        '''.strip(),
        epilog='''
Ejemplos:

  # Configurar hooks (recomendado después de clonar)
  python install.py setup-githooks
  
  # Solo configurar hooks sin arreglar permisos
  python install.py setup-githooks --no-fix-permissions
  
  # Desactivar hooks personalizados (revertir)
  python install.py setup-githooks --disable
  
  # Usar directorio de hooks personalizado
  python install.py setup-githooks --hooks-dir custom-hooks

Esto ejecuta: git config core.hooksPath .githooks
Para revertir: python install.py setup-githooks --disable
        '''.strip(),
        formatter_class=argparse.RawDescriptionHelpFormatter
    )
    githooks_parser.add_argument(
        '--hooks-dir',
        default='.githooks',
        help='Directorio de hooks (default: .githooks)'
    )
    githooks_parser.add_argument(
        '--no-fix-permissions',
        action='store_true',
        help='No arreglar permisos ejecutables en archivos con shebang'
    )
    githooks_parser.add_argument(
        '--disable',
        action='store_true',
        help='Desactivar hooks personalizados (revertir a hooks por defecto de Git)'
    )
    
    args = parser.parse_args()
    
    # Verificar dependencias solo si se va a ejecutar un comando real
    # (no al mostrar --help)
    print("Verificando dependencias...")
    if not check_and_install_pyyaml():
        return 1
    
    check_and_install_git_lfs(interactive=True)  # Non-fatal if fails
    print()
    
    # Si no se especifica subcomando, usar 'install' por defecto
    if args.command is None:
        # Modo compatibilidad: sin subcomando = install
        # Re-parsear con install como default
        sys.argv.insert(1, 'install')
        args = parser.parse_args()
    
    # Ejecutar subcomando
    if args.command == 'help':
        parser.print_help()
        return 0
    elif args.command == 'install':
        return run_install(args)
    elif args.command == 'check-fonts':
        return run_check_fonts(args)
    elif args.command == 'check-gitlfs':
        return run_check_gitlfs(args)
    elif args.command == 'backup-list':
        return run_backup_list(args)
    elif args.command == 'backup-restore':
        return run_backup_restore(args)
    elif args.command == 'backup-clean':
        return run_backup_clean(args)
    elif args.command == 'update-submodules':
        return run_update_submodules(args)
    elif args.command == 'inspect-mappings':
        return run_inspect_mappings(args)
    elif args.command == 'setup-githooks':
        return run_setup_githooks(args)
    else:
        parser.print_help()
        return 1


def run_install(args):
    
    # Determine repository root
    script_dir = Path(__file__).parent
    repo_root = script_dir.parent  # scripts/ -> repo root
    
    # Determine target directory
    target = Path(args.target).expanduser() if args.target else Path.home()
    
    # Load configuration
    mappings_file = repo_root / 'install-mappings.yml'
    if not mappings_file.exists():
        print(f"[X] Mappings file not found: {mappings_file}")
        return 1
    
    print("Dotfiles Installer (Python)")
    print(f"Repository: {repo_root}")
    print(f"Target: {target}")
    print(f"Mappings: {mappings_file}")
    
    config = DotfilesConfig(str(mappings_file), str(target), str(repo_root))
    print(f"Loaded {len(config.global_mappings)} global + {len(config.module_mappings)} module mappings")
    print(f"Default action: {config.default_action}\n")
    
    # Initialize components
    mapper = FileMapper(config)
    symlink_mgr = SymlinkManager(target)
    
    # Determine modules to install
    if args.modules:
        # Use specified modules
        modules = [repo_root / m for m in args.modules]
    else:
        # Use default modules (all under modules/ except system)
        modules_dir = repo_root / 'modules'
        modules = []
        
        # Find all module directories
        for category_dir in modules_dir.iterdir():
            if not category_dir.is_dir() or category_dir.name == 'system':
                continue
            
            # Check if it's a category or direct module
            has_config_files = any(
                f.is_file() and not f.name.upper().startswith(('README', 'LICENSE'))
                for f in category_dir.iterdir()
            )
            
            if has_config_files:
                # Direct module (e.g., modules/pacman/)
                modules.append(category_dir)
            else:
                # Category - recursively add all subdirectories with config files
                # This handles cases like modules/desktop/wm/labwc, modules/shell/bash, etc.
                def find_modules_recursive(directory, depth=0, max_depth=3):
                    """Recursively find directories containing config files."""
                    found = []
                    if depth > max_depth:
                        return found
                    
                    for item in directory.iterdir():
                        if not item.is_dir():
                            continue
                        
                        # Check if this directory has config files
                        has_files = any(
                            f.is_file() and not f.name.upper().startswith(('README', 'LICENSE'))
                            for f in item.iterdir()
                        )
                        
                        if has_files:
                            found.append(item)
                        else:
                            # Recurse into subdirectories
                            found.extend(find_modules_recursive(item, depth + 1, max_depth))
                    
                    return found
                
                modules.extend(find_modules_recursive(category_dir))
    
    # Filtering themes by default
    with_gtk = args.with_gtk or args.with_themes
    with_qt = args.with_qt or args.with_themes
    
    if not modules:
        print("[X] No modules found to install")
        return 1
    
    # Filter modules if needed (only if installing all)
    if not args.modules:
        filtered_modules = []
        for m in modules:
            m_str = str(m).replace('\\', '/')
            is_gtk = '/gtk/' in m_str
            is_qt = '/qt/' in m_str
            
            if is_gtk and not with_gtk:
                # print(f"  (Saltando tema GTK: {m.name})") # Verbose?
                continue
            if is_qt and not with_qt:
                # print(f"  (Saltando componente QT: {m.name})")
                continue
            filtered_modules.append(m)
        modules = filtered_modules
    
    # Crear gestor de symlinks
    symlink_mgr = SymlinkManager(config.target)
    
    # Iniciar sesión de backup (timestamp compartido) si no se deshabilitó
    if not args.no_backup and not args.dry_run:
        symlink_mgr.start_backup_session()
    elif args.dry_run:
        print("🔍 DRY-RUN MODE: No se crearán symlinks ni backups\n")
    else:
        print("[X] Backups deshabilitados (--no-backup)\n")
    
    print(f"Modules to install: {len(modules)}\n")
    
    # Instalar cada módulo
    for module_path in modules:
        install_module(module_path, config, mapper, symlink_mgr, 
                      args.fix_eol, args.fix_attribs, 
                      allow_backup=not args.no_backup,
                      dry_run=args.dry_run)
    
    # Guardar metadata de backups (si se habilitaron)
    if not args.no_backup:
        symlink_mgr.save_backup_metadata()
    
    print(f"\n{'='*60}")
    print("[OK] Installation complete!")
    print(f"{'='*60}")
    
    # Verificar fuentes requeridas
    try:
        from dotfiles_installer.fonts import check_and_install_fonts
        
        # Verificar si estamos instalando módulos de terminal o editor
        terminal_modules = any('term' in str(m) or 'editor' in str(m) for m in modules)
        
        if terminal_modules:
            print("\nVerificando fuentes requeridas...")
            check_and_install_fonts(interactive=True, install_optional=False)
    except ImportError:
        pass  # fonts.py no disponible, omitir verificación
    
    print("\nTo apply system-level changes (Xorg, etc.), run with appropriate privileges.")
    if not args.no_backup:
        print("Backups are stored in: ~/.dotfiles_backup/")
        print("\nGestión de backups:")
        print("  python scripts/install.py backup-list              # Listar backups")
        print("  python scripts/install.py backup-restore --latest  # Restaurar último")
        print("  python scripts/install.py backup-clean 5           # Mantener últimos 5")
    
    return 0


def run_check_fonts(args):
    """Verificar e instalar fuentes requeridas."""
    from dotfiles_installer.fonts import check_and_install_fonts
    
    installed, missing = check_and_install_fonts(
        interactive=not args.non_interactive,
        install_optional=args.optional
    )
    
    # Exit code: 0 si todas las requeridas están, 1 si falta alguna
    return 0 if not missing else 1


def run_check_gitlfs(args):
    """Verificar e instalar git-lfs."""
    from dotfiles_installer.gitlfs import check_and_install_git_lfs
    
    success = check_and_install_git_lfs(interactive=not args.non_interactive)
    return 0 if success else 1


def run_backup_list(args):
    """Listar backups disponibles."""
    from dotfiles_installer.backup import list_backups
    list_backups(verbose=True)
    return 0


def run_backup_restore(args):
    """Restaurar un backup."""
    from dotfiles_installer.backup import restore_backup, get_backup_dir
    
    if args.latest:
        backup_dir = get_backup_dir()
        if not backup_dir.exists():
            print("[X] No hay backups disponibles", file=sys.stderr)
            return 1
        
        # Encontrar el más reciente
        backups = sorted([d.name for d in backup_dir.iterdir() if d.is_dir()], reverse=True)
        if not backups:
            print("[X] No hay backups disponibles", file=sys.stderr)
            return 1
        
        timestamp = backups[0]
        print(f"Restaurando backup más reciente: {timestamp}\n")
        return restore_backup(timestamp, args.dry_run)
    
    if args.timestamp:
        return restore_backup(args.timestamp, args.dry_run)
    
    print("[X] ERROR: Especifica --timestamp o --latest", file=sys.stderr)
    return 1


def run_backup_clean(args):
    """Limpiar backups antiguos."""
    from dotfiles_installer.backup import clean_old_backups
    
    if args.keep < 0:
        print("[X] ERROR: El número de backups a mantener debe ser >= 0", file=sys.stderr)
        return 1
    
    clean_old_backups(keep=args.keep, dry_run=args.dry_run)
    return 0


def run_update_submodules(args):
    """Actualizar submódulos git."""
    from dotfiles_installer.submodules import (
        update_repo_submodules,
        update_submodules_in_dir,
        run_git_command
    )
    
    script_dir = Path(__file__).parent
    repo_root = script_dir.parent
    
    # Actualizar submódulos en distros/PKGBUILD/ si existen
    distros_dir = repo_root / 'distros'
    if distros_dir.exists():
        update_submodules_in_dir(distros_dir, repo_root=repo_root, auto_commit=True)
    
    # También actualizar submódulos del repo principal
    update_repo_submodules(recursive=True)
    
    # Determinar directorio target
    if args.target_dir:
        target_dir = args.target_dir
    else:
        target_dir = Path('distros/PKGBUILD')
        if args.package:
            target_dir = target_dir / args.package
    
    # Actualizar submódulos en directorio
    updated = update_submodules_in_dir(target_dir, auto_commit=not args.no_commit)
    
    if updated == 0:
        print("\nNo se encontraron submódulos para actualizar")
        return 0
    
    print(f"\n[OK] {updated} submódulo(s) actualizado(s)")
    
    # Commit si se solicitó y hay cambios
    if not args.no_commit:
        print("\nConfirmando actualizaciones de submódulos...")
        try:
            run_git_command(
                ['git', 'commit', '-m', 'chore: update PKGBUILD submodules', '--no-verify'],
                check=False
            )
            print("[OK] Cambios commiteados")
            print("\nListo. Revisa con 'git status' y sube tu rama de trabajo.")
        except:
            print("No hay cambios para commitear")
    
    return 0


def run_inspect_mappings(args):
    """Inspeccionar install-mappings.yml."""
    from dotfiles_installer.inspect import inspect_mappings
    
    # Determinar ruta al archivo de mappings
    script_dir = Path(__file__).parent
    repo_root = script_dir.parent
    mappings_file = repo_root / 'install-mappings.yml'
    
    return inspect_mappings(mappings_file, output_file=args.output, verbose=args.verbose)


def run_setup_githooks(args):
    """Configurar o desactivar git hooks."""
    from dotfiles_installer.githooks import setup_githooks, disable_githooks
    
    # Si se especificó --disable, desactivar hooks
    if args.disable:
        return disable_githooks()
    
    # Configurar hooks
    return setup_githooks(
        hooks_dir=args.hooks_dir,
        fix_permissions=not args.no_fix_permissions
    )


if __name__ == '__main__':
    sys.exit(main())
