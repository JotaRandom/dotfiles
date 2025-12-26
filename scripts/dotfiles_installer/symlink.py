#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Symlink management for dotfiles installer.

Handles creation of symlinks with automatic backup of existing files.
"""

import os
import shutil
import json
from pathlib import Path
from datetime import datetime
from typing import Optional, List, Dict


class SymlinkManager:
    """Manages creation of symlinks with backup functionality."""
    
    def __init__(self, target_dir: Path, backup_dir: Optional[Path] = None):
        """
        Initialize symlink manager.
        
        Args:
            target_dir: Base target directory (typically $HOME)
            backup_dir: Directory for backups (default: $HOME/.dotfiles_backup)
        """
        self.target = Path(target_dir)
        self.backup_base = backup_dir or (Path.home() / '.dotfiles_backup')
        
        # Estado de backup actual (timestamp compartido para sesión)
        self._backup_timestamp = None
        self._backup_metadata = {
            'timestamp': None,
            'modules_installed': set(),
            'files_backed_up': []
        }
    
    def start_backup_session(self):
        """Inicia una nueva sesión de backup con timestamp compartido."""
        self._backup_timestamp = datetime.now().strftime('%Y-%m-%d_%H-%M-%S')
        self._backup_metadata = {
            'timestamp': datetime.now().isoformat(),
            'modules_installed': set(),
            'files_backed_up': []
        }
    
    def save_backup_metadata(self):
        """Guarda metadata del backup actual."""
        if not self._backup_timestamp or not self._backup_metadata['files_backed_up']:
            return  # Sin backups, no crear metadata
        
        backup_dir = self.backup_base / self._backup_timestamp
        metadata_file = backup_dir / 'metadata.json'
        
        # Convertir set a list para JSON
        metadata_to_save = {
            'timestamp': self._backup_metadata['timestamp'],
            'modules_installed': sorted(list(self._backup_metadata['modules_installed'])),
            'files_backed_up': self._backup_metadata['files_backed_up']
        }
        
        try:
            with open(metadata_file, 'w', encoding='utf-8') as f:
                json.dump(metadata_to_save, f, indent=2, ensure_ascii=False)
            print(f"  📋 Metadata guardada: {metadata_file}")
        except Exception as e:
            print(f"  ⚠ Error guardando metadata: {e}")
    
    def create_symlink(self, source: Path, destination: Path, module_name: str,
                      allow_backup: bool = True, dry_run: bool = False) -> bool:
        """
        Create a symlink, backing up existing file if needed.
        
        Args:
            source: Source file to link to (must exist)
            destination: Destination path for symlink
            module_name: Name of module (for backup organization)
            allow_backup: If True, backup existing files; if False, skip if exists
            dry_run: If True, only show what would be done without making changes
        
        Returns:
            True if symlink was created, False if skipped
        """
        # Ensure source exists
        if not source.exists():
            print(f"  ⚠ Source does not exist: {source}")
            return False
        
        # DRY-RUN: Solo mostrar lo que se haría
        if dry_run:
            print(f"  [DRY-RUN] {destination} → {source}")
            return True  # Reportar como "exitoso" para contadores
        
        # Create destination parent directory
        destination.parent.mkdir(parents=True, exist_ok=True)
        
        # Check if destination already exists
        if destination.exists() or destination.is_symlink():
            # Check if it's already the correct symlink
            if self._is_correct_symlink(destination, source):
                print(f"  ✓ Symlink already correct: {destination.name}")
                return False
            
            # Backup existing file/directory if allowed
            if allow_backup:
                # Si es un directorio real y no un symlink, respaldarlo
                if destination.is_dir() and not destination.is_symlink():
                    self._create_backup(destination, module_name)
                    shutil.rmtree(destination)
                    print(f"  🗑 Directorio existente eliminado: {destination}")
                elif not destination.is_symlink():
                    # Regular file - create backup
                    self._create_backup(destination, module_name)
                    destination.unlink()
                else:
                    # Existing symlink
                    destination.unlink()
            else:
                return False
        
        # Create symlink
        try:
            # Ensure parent directory exists
            destination.parent.mkdir(parents=True, exist_ok=True)
            
            destination.symlink_to(source)
            print(f"  ✓ {destination} → {source}")
            return True
        except OSError as e:
            print(f"  ✗ Failed to create symlink {destination}: {e}")
            return False
    
    def _is_correct_symlink(self, link_path: Path, expected_target: Path) -> bool:
        """
        Check if a path is a symlink pointing to the expected target.
        
        Args:
            link_path: Path to check
            expected_target: Expected target of symlink
        
        Returns:
            True if link_path is a symlink to expected_target
        """
        if not link_path.is_symlink():
            return False
        
        try:
            # Resolve both to absolute paths for comparison
            actual_target = link_path.resolve()
            expected_resolved = expected_target.resolve()
            return actual_target == expected_resolved
        except (OSError, RuntimeError):
            return False
    
    def _create_backup(self, file_path: Path, module_name: str):
        """
        Create a backup of an existing file.
        
        Args:
            file_path: Path to file to backup
            module_name: Name of module (for organizing backups)
        """
        # Iniciar sesión de backup si no existe
        if not self._backup_timestamp:
            self.start_backup_session()
        
        # Create backup directory con timestamp
        backup_dir = self.backup_base / self._backup_timestamp
        backup_dir.mkdir(parents=True, exist_ok=True)
        
        # Backup file or directory
        backup_path = backup_dir / file_path.name
        try:
            if file_path.is_dir():
                shutil.copytree(file_path, backup_path)
                print(f"  📦 Backed up directory: {file_path.name}")
            else:
                shutil.copy2(file_path, backup_path)
                print(f"  📦 Backed up: {file_path.name}")
            
            # Agregar a metadata
            self._backup_metadata['modules_installed'].add(module_name)
            self._backup_metadata['files_backed_up'].append({
                'original': str(file_path),
                'backup': file_path.name,
                'module': module_name,
                'is_dir': file_path.is_dir()
            })
        except OSError as e:
            print(f"  ⚠ Backup failed for {file_path.name}: {e}")
    
    def verify_symlink(self, link_path: Path, expected_target: Path) -> bool:
        """
        Verify that a symlink exists and points to the correct target.
        
        Args:
            link_path: Path that should be a symlink
            expected_target: Expected target of the symlink
        
        Returns:
            True if symlink exists and is correct
        """
        if not link_path.exists():
            return False
        
        if not link_path.is_symlink():
            return False
        
        return self._is_correct_symlink(link_path, expected_target)
