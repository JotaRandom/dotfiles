#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Inspección y análisis de install-mappings.yml.

Genera reportes detallados de mappings globales, mappings por módulo,
estadísticas, y validación básica del archivo YAML.
"""

import sys
from pathlib import Path
from typing import Dict, List, Tuple
import yaml

# Configurar encoding para Windows
if sys.platform == 'win32':
    import io
    sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')
    sys.stderr = io.TextIOWrapper(sys.stderr.buffer, encoding='utf-8')


def load_mappings(mappings_file: Path) -> Tuple[Dict, Dict, str]:
    """
    Carga y parsea el archivo de mappings.
    
    Args:
        mappings_file: Ruta al archivo install-mappings.yml
    
    Returns:
        Tupla de (mappings_globales, mappings_modulo, default_action)
    """
    try:
        with open(mappings_file, 'r', encoding='utf-8') as f:
            data = yaml.safe_load(f)
    except yaml.YAMLError as e:
        print(f"ERROR: YAML inválido en {mappings_file}", file=sys.stderr)
        print(f"  {e}", file=sys.stderr)
        sys.exit(1)
    except (OSError, IOError) as e:
        print(f"ERROR: No se pudo leer {mappings_file}", file=sys.stderr)
        print(f"  {e}", file=sys.stderr)
        sys.exit(1)
    
    if not isinstance(data, dict):
        print(f"ERROR: {mappings_file} no contiene un diccionario válido", file=sys.stderr)
        sys.exit(1)
    
    # Extraer default_action
    default_action = data.get('default_action', 'link')
    
    # Separar mappings globales vs por módulo
    global_mappings = {}
    module_mappings = {}
    
    for key, value in data.items():
        if key == 'default_action':
            continue
        
        # Mapping por módulo (key|module format)
        if '|' in key:
            parts = key.split('|', 1)
            file_key = parts[0].strip()
            module = parts[1].strip()
            combined_key = f"{file_key}|{module}"
            module_mappings[combined_key] = value
        else:
            # Mapping global
            global_mappings[key] = value
    
    return global_mappings, module_mappings, default_action


def print_report(global_mappings: Dict, module_mappings: Dict, default_action: str, 
                output_file: Path = None, verbose: bool = False):
    """
    Imprime reporte detallado de mappings.
    
    Args:
        global_mappings: Mappings globales
        module_mappings: Mappings por módulo
        default_action: Acción por defecto
        output_file: Si se especifica, guardar también en archivo
        verbose: Si True, mostrar todos los mappings
    """
    lines = []
    
    # Header
    lines.append("=" * 70)
    lines.append("REPORTE DE MAPPINGS - install-mappings.yml")
    lines.append("=" * 70)
    lines.append("")
    
    # Estadísticas generales
    total_mappings = len(global_mappings) + len(module_mappings)
    lines.append(f"Default Action: {default_action}")
    lines.append(f"Total Mappings: {total_mappings}")
    lines.append(f"  - Globales: {len(global_mappings)}")
    lines.append(f"  - Por Módulo: {len(module_mappings)}")
    lines.append("")
    
    # Estadísticas por tipo de acción
    actions_count = {}
    
    for value in global_mappings.values():
        if isinstance(value, str):
            action = value.split(':')[0] if ':' in value else 'link'
        elif isinstance(value, list):
            action = 'multiple'
        else:
            action = 'unknown'
        actions_count[action] = actions_count.get(action, 0) + 1
    
    for value in module_mappings.values():
        if isinstance(value, str):
            action = value.split(':')[0] if ':' in value else 'link'
        elif isinstance(value, list):
            action = 'multiple'
        else:
            action = 'unknown'
        actions_count[action] = actions_count.get(action, 0) + 1
    
    lines.append("Distribución por tipo:")
    for action, count in sorted(actions_count.items()):
        lines.append(f"  - {action}: {count}")
    lines.append("")
    
    # Mappings globales
    lines.append("-" * 70)
    lines.append(f"MAPPINGS GLOBALES ({len(global_mappings)})")
    lines.append("-" * 70)
    
    if verbose or len(global_mappings) <= 20:
        for key in sorted(global_mappings.keys()):
            value = global_mappings[key]
            if isinstance(value, list):
                lines.append(f"{key}:")
                for item in value:
                    lines.append(f"  - {item}")
            else:
                lines.append(f"{key} => {value}")
    else:
        lines.append(f"(Mostrando primeros 20 de {len(global_mappings)})")
        for key in sorted(list(global_mappings.keys())[:20]):
            value = global_mappings[key]
            if isinstance(value, list):
                lines.append(f"{key}: [{len(value)} destinos]")
            else:
                lines.append(f"{key} => {value}")
        lines.append(f"... y {len(global_mappings) - 20} más (usa --verbose para ver todos)")
    lines.append("")
    
    # Mappings por módulo
    lines.append("-" * 70)
    lines.append(f"MAPPINGS POR MÓDULO ({len(module_mappings)})")
    lines.append("-" * 70)
    
    # Agrupar por módulo
    by_module = {}
    for key, value in module_mappings.items():
        if '|' in key:
            module = key.split('|', 1)[1]
            if module not in by_module:
                by_module[module] = []
            by_module[module].append((key, value))
    
    if verbose or len(module_mappings) <= 20:
        for module in sorted(by_module.keys()):
            lines.append(f"\n  Módulo: {module}")
            for key, value in sorted(by_module[module]):
                file_key = key.split('|', 1)[0]
                if isinstance(value, list):
                    lines.append(f"    {file_key}:")
                    for item in value:
                        lines.append(f"      - {item}")
                else:
                    lines.append(f"    {file_key} => {value}")
    else:
        shown = 0
        for module in sorted(by_module.keys()):
            if shown >= 20:
                break
            lines.append(f"\n  Módulo: {module} ({len(by_module[module])} mappings)")
            for key, value in sorted(by_module[module])[:5]:
                file_key = key.split('|', 1)[0]
                if isinstance(value, list):
                    lines.append(f"    {file_key}: [{len(value)} destinos]")
                else:
                    lines.append(f"    {file_key} => {value}")
                shown += 1
            if len(by_module[module]) > 5:
                lines.append(f"    ... y {len(by_module[module]) - 5} más")
        if sum(len(by_module[m]) for m in by_module.keys()) > shown:
            remaining = sum(len(by_module[m]) for m in by_module.keys()) - shown
            lines.append(f"\n... y {remaining} mappings más (usa --verbose para ver todos)")
    
    lines.append("")
    lines.append("=" * 70)
    
    # Imprimir a stdout
    output = '\n'.join(lines)
    print(output)
    
    # Guardar a archivo si se especificó
    if output_file:
        try:
            with open(output_file, 'w', encoding='utf-8') as f:
                f.write(output)
            print(f"\nReporte guardado en: {output_file}")
        except (OSError, IOError) as e:
            print(f"ADVERTENCIA: No se pudo guardar en {output_file}: {e}", file=sys.stderr)


def inspect_mappings(mappings_file: Path, output_file: Path = None, verbose: bool = False) -> int:
    """
    Inspecciona y genera reporte de mappings.
    
    Args:
        mappings_file: Ruta al archivo de mappings
        output_file: Archivo de salida opcional
        verbose: Mostrar todos los mappings
    
    Returns:
        0 si éxito, 1 si error
    """
    if not mappings_file.exists():
        print(f"ERROR: {mappings_file} no existe", file=sys.stderr)
        return 1
    
    global_mappings, module_mappings, default_action = load_mappings(mappings_file)
    print_report(global_mappings, module_mappings, default_action, output_file, verbose)
    
    return 0
