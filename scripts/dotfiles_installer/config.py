#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Configuration parser for dotfiles installer.

Handles parsing of install-mappings.yml and resolution of XDG paths.
"""

import os
import yaml
from pathlib import Path
from typing import Dict, Optional, Tuple


class DotfilesConfig:
    """Configuration manager for dotfiles installation."""
    
    def __init__(self, mappings_file: str, target_dir: str, repo_root: str):
        """
        Initialize configuration.
        
        Args:
            mappings_file: Path to install-mappings.yml
            target_dir: Target directory for installation (typically $HOME)
            repo_root: Root directory of dotfiles repository
        """
        self.mappings_file = Path(mappings_file)
        self.target = Path(target_dir).expanduser()
        self.repo_root = Path(repo_root)
        
        # XDG Base Directory paths
        # If target is not the default home, we should stay within the target for all paths
        # to ensure isolation during tests or specific installations.
        is_home = self.target == Path.home()
        
        if is_home:
            self.xdg_config_home = Path(os.environ.get('XDG_CONFIG_HOME', self.target / '.config'))
            self.xdg_data_home = Path(os.environ.get('XDG_DATA_HOME', self.target / '.local/share'))
            self.xdg_state_home = Path(os.environ.get('XDG_STATE_HOME', self.target / '.local/state'))
            self.xdg_cache_home = Path(os.environ.get('XDG_CACHE_HOME', self.target / '.cache'))
        else:
            self.xdg_config_home = self.target / '.config'
            self.xdg_data_home = self.target / '.local/share'
            self.xdg_state_home = self.target / '.local/state'
            self.xdg_cache_home = self.target / '.cache'
        
        # Configuration data
        self.default_action = "dotify"
        self.global_mappings: Dict[str, str] = {}
        self.module_mappings: Dict[str, str] = {}
        
        # Load mappings if file exists
        if self.mappings_file.exists():
            self._load_mappings()
    
    def _load_mappings(self):
        """Parse install-mappings.yml and populate mapping dictionaries."""
        try:
            with open(self.mappings_file, 'r', encoding='utf-8') as f:
                data = yaml.safe_load(f)
            
            if not data:
                return
            
            for key, value in data.items():
                # Handle default_action
                if key == 'default_action':
                    self.default_action = value
                    continue
                
                # Skip empty values
                if value is None:
                    continue
                
                # Convert list values to comma-separated string (YAML lists)
                if isinstance(value, list):
                    value = ','.join(str(v) for v in value)
                else:
                    value = str(value)
                
                # Determine if it's a module-specific mapping (contains |)
                if '|' in key:
                    # Module-specific: filename|module
                    self.module_mappings[key] = value
                else:
                    # Global mapping
                    self.global_mappings[key] = value
        
        except yaml.YAMLError as e:
            raise ValueError(f"Error parsing YAML file {self.mappings_file}: {e}")
        except FileNotFoundError:
            raise FileNotFoundError(f"Mappings file not found: {self.mappings_file}")
    
    def expand_xdg_path(self, spec: str) -> Path:
        """
        Expand XDG path specification to actual path.
        
        Args:
            spec: Path specification (e.g., "xdg:nvim/init.vim", "home:.bashrc")
        
        Returns:
            Expanded Path object
        """
        if spec.startswith('xdg:'):
            return self.xdg_config_home / spec[4:]
        elif spec.startswith('xdg_state:'):
            return self.xdg_state_home / spec[10:]
        elif spec.startswith('xdg_data:'):
            return self.xdg_data_home / spec[9:]
        elif spec.startswith('xdg_cache:'):
            return self.xdg_cache_home / spec[10:]
        elif spec.startswith('home:'):
            return self.target / spec[5:]
        else:
            # Default: relative to target
            return self.target / spec
    
    def get_mapping(self, filename: str, module_name: Optional[str] = None) -> Tuple[Optional[str], bool]:
        """
        Get mapping destination for a file.
        
        Args:
            filename: Name or relative path of file
            module_name: Optional module name for module-specific lookups
        
        Returns:
            Tuple of (mapping_value, is_explicit) where:
            - mapping_value: The mapping destination or None if no explicit mapping
            - is_explicit: True if there's an explicit mapping, False otherwise
        """
        # Try module-specific mapping first (highest priority)
        if module_name:
            # Try with full relative path
            key = f"{filename}|{module_name}"
            if key in self.module_mappings:
                return self.module_mappings[key], True
            
            # Try with just basename
            basename = Path(filename).name
            key = f"{basename}|{module_name}"
            if key in self.module_mappings:
                return self.module_mappings[key], True

            # Try wildcard mapping (e.g., *|module_name)
            wildcard_key = f"*|{module_name}"
            if wildcard_key in self.module_mappings:
                return self.module_mappings[wildcard_key], True
        
        # Try global mapping with full path
        if filename in self.global_mappings:
            return self.global_mappings[filename], True
        
        # Try global mapping with basename
        basename = Path(filename).name
        if basename in self.global_mappings:
            return self.global_mappings[basename], True
        
        # No explicit mapping found
        return None, False
    
    def __repr__(self):
        return (f"DotfilesConfig(target={self.target}, "
                f"default_action={self.default_action}, "
                f"global_mappings={len(self.global_mappings)}, "
                f"module_mappings={len(self.module_mappings)})")
