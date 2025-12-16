#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Test completo de instalación de dotfiles.

Ejecuta install.py en directorio temporal y verifica que todos los symlinks
se creen correctamente según install-mappings.yml.

Este script es un reemplazo completo y mejorado de test-install-mappings.sh
con 100% de paridad funcional:

- ✓ Detección de secretos en modules/
- ✓ Verificación de todos los mappings del YAML
- ✓ Soporte para mappings múltiples y formato key|module
- ✓ Detección de archivos sanitizados con verificación CRLF
- ✓ Verificación de coherencia de directorios
- ✓ Prueba de portabilidad (ejecución desde diferentes directorios)
- ✓ Códigos de salida idénticos (0=OK, 1=error, 3=directorios, 4=secretos)

Ventajas sobre el bash:
- Usa yaml.safe_load() para parsing robusto del YAML
- Mejor manejo de excepciones y errores
- Código más legible y mantenible
- Integración directa con la infraestructura Python del instalador
"""

import sys
import os
import tempfile
import subprocess
import yaml
from pathlib import Path

# Configurar encoding para Windows
if sys.platform == 'win32':
    import io
    sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')
    sys.stderr = io.TextIOWrapper(sys.stderr.buffer, encoding='utf-8')

# Agregar scripts al path
sys.path.insert(0, str(Path(__file__).parent.parent.parent / 'scripts'))

from dotfiles_installer.config import DotfilesConfig
from dotfiles_installer.mapper import FileMapper


def run_installer(repo_root: Path, target_dir: Path, modules: list) -> int:
    """
    Ejecuta install.py en directorio temporal.
    
    Args:
        repo_root: Raíz del repositorio
        target_dir: Directorio destino temporal
        modules: Lista de módulos a instalar
    
    Returns:
        Código de salida del instalador
    """
    install_script = repo_root / 'scripts' / 'install.py'
    
    # Construir comando (con subcomando 'install')
    cmd = [
        sys.executable,
        str(install_script),
        'install',  # ← Subcomando agregado
        '--target', str(target_dir)
    ] + [str(m) for m in modules]
    
    # Ejecutar
    print(f"Ejecutando: {' '.join(cmd)}\n")
    result = subprocess.run(cmd, cwd=repo_root, capture_output=True, text=True)
    
    if result.stdout:
        print(result.stdout)
    if result.stderr:
        print(result.stderr, file=sys.stderr)
    
    return result.returncode


def is_template(file_path: Path) -> bool:
    """
    Verifica si un archivo es una plantilla (vacío, solo comentarios, o JSON trivial).
    
    Los archivos plantilla NO deberían generar symlinks.
    """
    # Archivos vacíos son plantillas
    if file_path.stat().st_size == 0:
        return True
    
    # JSON con solo {} o []
    if file_path.suffix.lower() == '.json':
        try:
            content = file_path.read_text(encoding='utf-8', errors='ignore')
            trimmed = content.strip().replace(' ', '').replace('\t', '').replace('\n', '').replace('\r', '')
            if trimmed in ['{}', '[]']:
                return True
        except:
            pass
    
    # Claves privadas no vacías NO son plantillas
    name = file_path.name
    if name in ['id_rsa', 'id_ed25519'] or name.startswith('id_') and name.endswith('_priv'):
        return False
    
    # Archivos solo con comentarios
    try:
        with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
            for line in f:
                stripped = line.strip()
                # Ignorar líneas vacías y comentarios
                if stripped and not stripped.startswith(('#', '//', ';')):
                    return False  # Encontró contenido real
        return True  # Solo comentarios o vacío
    except:
        return False


def check_for_secrets(repo_root: Path) -> int:
    """
    Verifica que no haya archivos sensibles con contenido real en modules/.
    
    Args:
        repo_root: Raíz del repositorio
    
    Returns:
        Número de errores encontrados (0 = OK)
    """
    # Patrones que frecuentemente contienen credenciales
    SECRET_PATTERNS = [
        '.git-credentials',
        '.netrc',
        '.npmrc',
        '.docker/config.json',
        '.aws/credentials',
        '.ssh/id_rsa',
        '.ssh/id_ed25519',
    ]
    
    modules_dir = repo_root / 'modules'
    secret_errors = 0
    
    for pattern in SECRET_PATTERNS:
        # Buscar archivos que coincidan con el patrón
        if '/' in pattern:
            # Patrón con ruta
            found = list(modules_dir.glob(f"**/{pattern}"))
        else:
            # Solo nombre
            found = list(modules_dir.glob(f"**/{pattern}"))
        
        for file_path in found:
            if not file_path.is_file():
                continue
            
            # Ignorar archivos .example o .sample
            if file_path.name.endswith('.example') or file_path.name.endswith('.sample'):
                continue
            
            # Si es plantilla/vacío, está OK
            if is_template(file_path):
                print(f"OK: archivo de plantilla/ejemplo encontrado (permitido): {file_path.relative_to(repo_root)}")
                continue
            
            # Si llega aquí, es un probable secreto
            print(f"ERROR: encontrado probable secreto en módulos del repositorio: {file_path.relative_to(repo_root)}", file=sys.stderr)
            secret_errors += 1
    
    return secret_errors


def find_source_file(repo_root: Path, mapping_key: str, module_override: str = None) -> list:
    """
    Busca archivos fuente en modules/ que coincidan con la clave de mapping.
    
    Args:
        repo_root: Raíz del repositorio
        mapping_key: Clave del mapping (ej: ".bashrc", "fish/config.fish")
        module_override: Nombre del módulo específico (si está en formato "key|module")
    
    Returns:
        Lista de rutas de archivos encontrados
    """
    modules_dir = repo_root / 'modules'
    found_paths = []
    
    # Si tiene barra, es una ruta relativa
    if '/' in mapping_key:
        if module_override:
            # Buscar en módulo específico
            # Primero intentar directamente
            mod_dir = modules_dir / module_override
            if not mod_dir.exists():
                # Buscar recursivamente
                for candidate in modules_dir.rglob(module_override):
                    if candidate.is_dir():
                        mod_dir = candidate
                        break
            
            if mod_dir.exists():
                # BUGFIX: Si mapping_key empieza con el nombre del módulo, eliminarlo
                search_path = mapping_key
                first_component = mapping_key.split('/')[0]
                
                if first_component == module_override:
                    # Eliminar componente duplicado
                    search_path = '/'.join(mapping_key.split('/')[1:])
                
                src_file = mod_dir / search_path
                if src_file.is_file():
                    found_paths.append(src_file)
        else:
            # Buscar en todos los módulos
            pattern = f"**/{mapping_key}"
            found_paths = list(modules_dir.glob(pattern))
            found_paths = [p for p in found_paths if p.is_file()]
    else:
        # Solo nombre base
        if module_override:
            # Buscar en módulo específico
            mod_dir = modules_dir / module_override
            if not mod_dir.exists():
                for candidate in modules_dir.rglob(module_override):
                    if candidate.is_dir():
                        mod_dir = candidate
                        break
            
            if mod_dir.exists():
                pattern = f"**/{mapping_key}"
                found_paths = list(mod_dir.glob(pattern))
                found_paths = [p for p in found_paths if p.is_file()]
        else:
            # Buscar en todos los módulos
            pattern = f"**/{mapping_key}"
            found_paths = list(modules_dir.glob(pattern))
            found_paths = [p for p in found_paths if p.is_file()]
    
    return found_paths


def verify_symlink(expected: Path, src: Path, mapping_key: str, target_dir: Path) -> tuple:
    """
    Verifica un symlink individual.
    
    Args:
        expected: Ruta esperada del symlink
        src: Archivo fuente original
        mapping_key: Clave del mapping
        target_dir: Directorio destino
    
    Returns:
        Tupla (ok: bool, mensaje: str)
    """
    # Verificar existencia
    if not expected.exists() and not expected.is_symlink():
        return False, f"ERROR: el destino esperado no existe para el mapeo '{mapping_key}': {expected} (origen: {src})"
    
    if not expected.is_symlink():
        return False, f"ERROR: el destino esperado no es un enlace simbólico para el mapeo '{mapping_key}': {expected} (origen: {src})"
    
    # Verificar objetivo del enlace
    try:
        target = expected.resolve()
        source = src.resolve()
        
        if target == source:
            return True, f"OK: {expected} -> {src}"
        
        # Verificar si es copia saneada
        sanitized_prefix = target_dir / '.dotfiles_sanitized'
        if str(target).startswith(str(sanitized_prefix)):
            if not target.is_file():
                return False, f"ERROR: no existe el archivo saneado esperado: {target} (origen: {src})"
            
            # Verificar que no contiene CRLF
            try:
                content = target.read_bytes()
                if b'\r\n' in content:
                    return False, f"ERROR: el archivo saneado aún contiene CRLF: {target}"
            except:
                pass
            
            return True, f"OK: {expected} -> {target} (copia saneada de {src})"
        
        return False, f"ERROR: discrepancia en el objetivo del enlace para el mapeo '{mapping_key}'. Se esperaba <{source}>, pero se encontró <{target}>. (dest: {expected})"
    
    except Exception as e:
        return False, f"ERROR: excepción al verificar {expected}: {e}"


def verify_installation(repo_root: Path, target_dir: Path, modules: list) -> tuple:
    """
    Verifica que todos los symlinks esperados se hayan creado.
    
    Imita la lógica de test-install-mappings.sh:
    1. Lee todas las claves del install-mappings.yml
    2. Para cada clave, busca archivos fuente en modules/
    3. Verifica que existan symlinks en los destinos esperados
    4. Verifica que los symlinks apunten a los archivos correctos
    
    Args:
        repo_root: Raíz del repositorio
        target_dir: Directorio destino
        modules: Lista de módulos instalados
    
    Returns:
        Tupla (errores, warnings, mapping_keys)
    """
    mappings_file = repo_root / 'install-mappings.yml'
    config = DotfilesConfig(str(mappings_file), str(target_dir), str(repo_root))
    mapper = FileMapper(config)
    
    errors = []
    warnings = []
    checked = 0
    
    print("\n" + "="*60)
    print("Verificando symlinks instalados")
    print("="*60 + "\n")
    
    # Leer TODAS las claves del YAML (igual que bash)
    import yaml
    with open(mappings_file, 'r', encoding='utf-8') as f:
        mappings_data = yaml.safe_load(f)
    
    if not mappings_data:
        print("WARNING: No se encontraron mappings en install-mappings.yml")
        return errors, warnings, []
    
    # Extraer todas las claves (excluyendo 'default_action')
    mapping_keys = [k for k in mappings_data.keys() if k != 'default_action']
    
    print(f"Total de claves en mappings: {len(mapping_keys)}\n")
    
    # Verificar cada clave del YAML
    for mapping_key in mapping_keys:
        mapping_value = mappings_data[mapping_key]
        
        # Si es 'ignore' o 'skip', omitir
        if isinstance(mapping_value, str) and mapping_value.strip() in ['ignore', 'skip']:
            continue
        
        # Parsear clave y módulo (formato: "key|module")
        key = mapping_key
        module_override = None
        if '|' in mapping_key:
            parts = mapping_key.split('|')
            key = parts[0]
            module_override = parts[1]
        
        # Buscar archivos fuente
        found_paths = find_source_file(repo_root, key, module_override)
        
        if not found_paths:
            # Distinguir entre templates y archivos realmente faltantes
            if mapping_key.endswith('.example'):
                print(f"OK: archivo de plantilla/ejemplo: {mapping_key}")
                continue
            else:
                warnings.append(f"NOTA: el mapeo '{mapping_key}' apunta a '{mapping_value}' pero no se encontró archivo fuente en modules")
                continue
        
        # Para cada archivo fuente encontrado
        for src in found_paths:
            # Si el valor contiene comas, es un mapeo múltiple
            if isinstance(mapping_value, str) and ',' in mapping_value:
                # Procesar cada destino
                dest_specs = [s.strip() for s in mapping_value.split(',')]
                
                for spec in dest_specs:
                    # Resolver spec a ruta completa usando config
                    dest = config.expand_xdg_path(spec)
                    
                    checked += 1
                    ok, msg = verify_symlink(dest, src, mapping_key, target_dir)
                    
                    if ok:
                        print(msg)
                    else:
                        errors.append(msg)
            else:
                # Mapeo simple
                if module_override:
                    destinations, action, _ = mapper.resolve_destination(key, module_override)
                else:
                    # Necesitamos detectar el módulo desde la ruta del archivo
                    modules_dir = repo_root / 'modules'
                    try:
                        rel_to_modules = src.relative_to(modules_dir)
                        module_name = rel_to_modules.parts[0]
                        destinations, action, _ = mapper.resolve_destination(key, module_name)
                    except:
                        destinations = []
                        action = None
                
                if action == 'ignore':
                    continue
                
                for dest in destinations:
                    checked += 1
                    ok, msg = verify_symlink(dest, src, mapping_key, target_dir)
                    
                    if ok:
                        print(msg)
                    else:
                        errors.append(msg)
    
    print(f"\nTotal de destinos verificados: {checked}")
    
    return errors, warnings, mapping_keys


def verify_directory_coherence(repo_root: Path, target_dir: Path, mapping_keys: list) -> int:
    """
    Verifica que no se crearon directorios top-level cuando se esperaban symlinks a archivos.
    
    Args:
        repo_root: Raíz del repositorio
        target_dir: Directorio destino
        mapping_keys: Lista de claves del mapping YAML
    
    Returns:
        Número de directorios incorrectos encontrados
    """
    print("\n" + "="*60)
    print("Verificando coherencia de directorios")
    print("="*60 + "\n")
    
    bad_dirs = 0
    
    for k in mapping_keys:
        if not k:
            continue
        
        # Extraer clave sin módulo (eliminar |module si existe)
        key = k
        if '|' in key:
            key = key.split('|')[0]
        
        # Obtener nombre base
        base = Path(key).name
        
        # Si es dotfile (.bashrc), verificar que no existe el directorio sin punto (bashrc)
        if base.startswith('.'):
            bare = base[1:]  # Quitar el punto
            unwanted_dir = target_dir / bare
            
            if unwanted_dir.is_dir():
                print(f"ERROR: encontrado directorio no deseado {unwanted_dir} correspondiente al mapeo '{k}' (se esperaba un symlink a archivo)", file=sys.stderr)
                bad_dirs += 1
        else:
            # Para archivos normales, verificar que no existe directorio con ese nombre
            unwanted_dir = target_dir / base
            
            if unwanted_dir.is_dir():
                print(f"ERROR: encontrado directorio no deseado {unwanted_dir} correspondiente al mapeo '{k}' (se esperaba un symlink a archivo)", file=sys.stderr)
                bad_dirs += 1
    
    if bad_dirs > 0:
        print(f"\nSe encontraron {bad_dirs} directorios no deseados que coinciden con nombres base de mapeos")
    else:
        print("OK: No se encontraron directorios no deseados")
    
    return bad_dirs


def verify_installer_from_different_directory(repo_root: Path, modules: list) -> bool:
    """
    Verifica que install.py funciona correctamente desde diferentes directorios.
    
    Args:
        repo_root: Raíz del repositorio
        modules: Lista de módulos disponibles
    
    Returns:
        True si la verificación pasó, False en caso contrario
    """
    if not modules:
        return True
    
    print("\n" + "="*60)
    print("Verificando que install.py funciona desde diferentes directorios")
    print("="*60 + "\n")
    
    # Usar el primer módulo para la prueba
    test_module = modules[0]
    
    # Crear directorio temporal para ejecutar desde allí
    with tempfile.TemporaryDirectory() as test_subdir:
        with tempfile.TemporaryDirectory() as test_target:
            # Guardar directorio actual
            original_cwd = os.getcwd()
            
            try:
                # Cambiar al subdirectorio temporal
                os.chdir(test_subdir)
                
                install_script = repo_root / 'scripts' / 'install.py'
                
                # Ejecutar instalador desde el subdirectorio temporal
                cmd = [
                    sys.executable,
                    str(install_script),
                    '--target', str(test_target),
                    str(test_module)
                ]
                
                result = subprocess.run(
                    cmd, 
                    cwd=test_subdir,
                    capture_output=True,
                    text=True
                )
                
                if result.returncode != 0:
                    print(f"ERROR: install.py falló cuando se ejecutó desde un directorio diferente ({test_subdir})", file=sys.stderr)
                    if result.stderr:
                        print(result.stderr, file=sys.stderr)
                    return False
                
                # Verificar que se creó al menos algo en el target
                test_target_path = Path(test_target)
                created_items = list(test_target_path.rglob('*'))
                
                # Filtrar solo archivos/symlinks de primer y segundo nivel
                created_items = [
                    item for item in created_items 
                    if len(item.relative_to(test_target_path).parts) <= 2
                ]
                
                if not created_items:
                    print(f"ERROR: install.py no creó ningún archivo cuando se ejecutó desde un directorio diferente", file=sys.stderr)
                    return False
                
                print(f"OK: install.py funciona correctamente desde diferentes directorios")
                return True
                
            finally:
                # Restaurar directorio original
                os.chdir(original_cwd)




def test_subcommands(repo_root: Path) -> bool:
    """
    Prueba todos los subcomandos de install.py.
    
    Args:
        repo_root: Raíz del repositorio
    
    Returns:
        True si todos los tests pasaron
    """
    print("\n" + "="*60)
    print("TEST DE SUBCOMANDOS")
    print("="*60)
    
    install_script = repo_root / 'scripts' / 'install.py'
    errors = 0
    
    # Test 1: inspect-mappings
    print("\n[1/7] Probando 'inspect-mappings'...")
    try:
        result = subprocess.run(
            [sys.executable, str(install_script), 'inspect-mappings'],
            cwd=repo_root,
            capture_output=True,
            text=True,
            timeout=30
        )
        if result.returncode == 0:
            print("  ✓ inspect-mappings OK")
        else:
            print(f"  ✗ inspect-mappings FALLÓ (exit {result.returncode})")
            print(f"    stderr: {result.stderr[:200]}")
            errors += 1
    except Exception as e:
        print(f"  ✗ inspect-mappings ERROR: {e}")
        errors += 1
    
    # Test 2: backup-list (sin backups aún, pero no debe fallar)
    print("\n[2/7] Probando 'backup-list'...")
    try:
        result = subprocess.run(
            [sys.executable, str(install_script), 'backup-list'],
            cwd=repo_root,
            capture_output=True,
            text=True,
            timeout=10
        )
        if result.returncode == 0:
            print("  ✓ backup-list OK")
        else:
            print(f"  ✗ backup-list FALLÓ (exit {result.returncode})")
            errors += 1
    except Exception as e:
        print(f"  ✗ backup-list ERROR: {e}")
        errors += 1
    
    # Test 3: backup-restore --latest --dry-run (debe fallar gracefully si no hay backups)
    print("\n[3/7] Probando 'backup-restore --latest --dry-run'...")
    try:
        result = subprocess.run(
            [sys.executable, str(install_script), 'backup-restore', '--latest', '--dry-run'],
            cwd=repo_root,
            capture_output=True,
            text=True,
            timeout=10
        )
        # Puede ser 0 (éxito) o 1 (no hay backups), ambos son válidos
        if result.returncode in [0, 1]:
            print("  ✓ backup-restore OK (comportamiento esperado)")
        else:
            print(f"  ✗ backup-restore FALLÓ (exit {result.returncode})")
            errors += 1
    except Exception as e:
        print(f"  ✗ backup-restore ERROR: {e}")
        errors += 1
    
    # Test 4: backup-clean 5 --dry-run
    print("\n[4/7] Probando 'backup-clean 5 --dry-run'...")
    try:
        result = subprocess.run(
            [sys.executable, str(install_script), 'backup-clean', '5', '--dry-run'],
            cwd=repo_root,
            capture_output=True,
            text=True,
            timeout=10
        )
        if result.returncode == 0:
            print("  ✓ backup-clean OK")
        else:
            print(f"  ✗ backup-clean FALLÓ (exit {result.returncode})")
            errors += 1
    except Exception as e:
        print(f"  ✗ backup-clean ERROR: {e}")
        errors += 1
    
    # Test 5: update-submodules (solo si hay distros/PKGBUILD/)
    print("\n[5/7] Probando 'update-submodules' (si aplica)...")
    pkgbuild_dir = repo_root / 'distros' / 'PKGBUILD'
    if pkgbuild_dir.exists():
        try:
            # Con --no-commit para no modificar el repo
            result = subprocess.run(
                [sys.executable, str(install_script), 'update-submodules', '--no-commit'],
                cwd=repo_root,
                capture_output=True,
                text=True,
                timeout=60
            )
            if result.returncode == 0:
                print("  ✓ update-submodules OK")
            else:
                print(f"  ✗ update-submodules FALLÓ (exit {result.returncode})")
                print(f"    stderr: {result.stderr[:200]}")
                errors += 1
        except Exception as e:
            print(f"  ✗ update-submodules ERROR: {e}")
            errors += 1
    else:
        print("  ⊘ update-submodules SKIP (no hay distros/PKGBUILD/)")
    
    # Test 6: setup-githooks
    print("\n[6/7] Probando 'setup-githooks'...")
    try:
        result = subprocess.run(
            [sys.executable, str(install_script), 'setup-githooks'],
            cwd=repo_root,
            capture_output=True,
            text=True,
            timeout=30
        )
        if result.returncode == 0:
            print("  ✓ setup-githooks OK")
        else:
            print(f"  ✗ setup-githooks FALLÓ (exit {result.returncode})")
            print(f"    stderr: {result.stderr[:200]}")
            errors += 1
    except Exception as e:
        print(f"  ✗ setup-githooks ERROR: {e}")
        errors += 1
    
    # Test 7: setup-githooks --disable
    print("\n[7/7] Probando 'setup-githooks --disable'...")
    try:
        result = subprocess.run(
            [sys.executable, str(install_script), 'setup-githooks', '--disable'],
            cwd=repo_root,
            capture_output=True,
            text=True,
            timeout=10
        )
        if result.returncode == 0:
            print("  ✓ setup-githooks --disable OK")
        else:
            print(f"  ✗ setup-githooks --disable FALLÓ (exit {result.returncode})")
            errors += 1
    except Exception as e:
        print(f"  ✗ setup-githooks --disable ERROR: {e}")
        errors += 1
    
    # Resumen
    print("\n" + "="*60)
    if errors == 0:
        print("✓ TODOS LOS SUBCOMANDOS FUNCIONAN CORRECTAMENTE")
        print("="*60)
        return True
    else:
        print(f"✗ {errors} SUBCOMANDO(S) FALLÓ/FALLARON")
        print("="*60)
        return False


def main():

    """Test principal."""
    print("="*60)
    print("Test de Instalación Completa - install.py")
    print("="*60 + "\n")
    
    # Obtener raíz del repositorio
    repo_root = Path(__file__).parent.parent.parent
    
    # Módulos a instalar - buscar directorios con archivos de config
    # Simular lógica de bash: find modules -mindepth 1 -maxdepth 3 -type d
    modules_dir = repo_root / 'modules'
    if not modules_dir.exists():
        print("ERROR: Directorio modules/ no encontrado", file=sys.stderr)
        return 1
    
    # Verificar que no haya secretos antes de ejecutar las pruebas
    print("Verificando ausencia de secretos en modules/...\n")
    secret_errors = check_for_secrets(repo_root)
    
    if secret_errors > 0:
        print(f"\nRechazando ejecutar pruebas de mapeo: se encontraron {secret_errors} archivo(s) que parecen secretos en modules.", file=sys.stderr)
        return 4
    
    print("OK: No se encontraron secretos\n")
    
    # Buscar módulos (directorios que contengan archivos, no subdirectorios de otros módulos)
    def find_modules(base_dir: Path, max_depth: int = 3) -> list:
        """Encuentra módulos buscando directorios con archivos de configuración."""
        modules = []
        
        def scan_dir(current_dir: Path, depth: int):
            if depth > max_depth:
                return
            
            # Verificar si este directorio tiene archivos de configuración
            has_config_files = False
            for item in current_dir.iterdir():
                if item.is_file():
                    # Ignorar README, LICENSE
                    name_upper = item.name.upper()
                    if not (name_upper.startswith('README') or 
                           name_upper.startswith('LICENSE')):
                        has_config_files = True
                        break
            
            if has_config_files:
                # Este es un módulo
                modules.append(current_dir)
                return  # No buscar subdirectorios (evitar duplicados)
            
            # Si no tiene archivos, buscar en subdirectorios
            for item in current_dir.iterdir():
                if item.is_dir():
                    scan_dir(item, depth + 1)
        
        # Empezar desde cada categoría
        for category in base_dir.iterdir():
            if category.is_dir():
                scan_dir(category, 1)
        
        return sorted(modules)
    
    modules = find_modules(modules_dir)
    
    if not modules:
        print("ERROR: No se encontraron módulos", file=sys.stderr)
        return 1
    
    print(f"Módulos a instalar: {len(modules)}")
    for m in modules:
        rel = m.relative_to(modules_dir)
        print(f"  - {rel}")
    
    # Crear directorio temporal
    with tempfile.TemporaryDirectory() as tmpdir:
        target = Path(tmpdir)
        print(f"\nDirectorio temporal: {target}\n")
        
        # Ejecutar instalador
        exit_code = run_installer(repo_root, target, modules)
        
        if exit_code != 0:
            print(f"\nERROR: Instalador falló con código {exit_code}", file=sys.stderr)
            return 1
        
        # NOTA: El script bash hace un 'sleep 1' aquí por si el instalador hace fork de procesos.
        # install.py es completamente síncrono (no usa threads/fork), así que no es necesario.
        
        # Verificar instalación
        errors, warnings, mapping_keys = verify_installation(repo_root, target, modules)
        
        # Verificación adicional: coherencia de directorios
        bad_dirs = verify_directory_coherence(repo_root, target, mapping_keys)
        
        if bad_dirs > 0:
            print(f"\nERROR: Se encontraron {bad_dirs} directorios no deseados", file=sys.stderr)
            return 3
        
        # Reportar resultados - SIN TRUNCAR
        print("\n" + "="*60)
        print("Resultados")
        print("="*60)
        
        if warnings:
            print(f"\nWarnings: {len(warnings)}")
            for w in warnings:
                print(f"  ⚠ {w}")
        
        if errors:
            print(f"\nErrores: {len(errors)}")
            for e in errors:
                print(f"  ✗ {e}")
            print("\n" + "="*60)
            return 1
        else:
            print("\n✓ Todos los symlinks verificados correctamente")
            print("="*60)
    
    # Verificación adicional: probar que funciona desde diferentes directorios
    # (esta prueba se hace FUERA del with tempfile para que use un nuevo target)
    if not verify_installer_from_different_directory(repo_root, modules):
        return 1
    
    # Test de subcomandos
    if not test_subcommands(repo_root):
        print("\n✗ Algunos subcomandos no pasaron las pruebas")
        return 1
    
    print("\n" + "="*60)
    print("✓ TODAS LAS VERIFICACIONES PASARON")
    print("="*60)
    return 0


if __name__ == '__main__':
    sys.exit(main())
