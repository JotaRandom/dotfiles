"""
File mapper for dotfiles installer.

Handles resolution of source files to destination paths using mapping rules.
"""

from pathlib import Path
from typing import List, Optional, Tuple
from .config import DotfilesConfig


class FileMapper:
    """Maps source files to their installation destinations."""
    
    def __init__(self, config: DotfilesConfig):
        """
        Initialize mapper with configuration.
        
        Args:
            config: DotfilesConfig instance with loaded mappings
        """
        self.config = config
    
    def resolve_destination(self, source_file: str, module_name: str) -> Tuple[List[Path], bool, str]:
        """
        Resolve where a source file should be installed.
        
        Args:
            source_file: Relative path of file within module
            module_name: Name of the module (e.g., "bash", "nvim")
        
        Returns:
            Tuple of (destinations, is_explicit, action) where:
            - destinations: List of Path objects where file should be symlinked
            - is_explicit: True if mapping was explicitly defined, False if using default_action
            - action: The action to take ("ignore", "dotify", "home", or mapping value)
        """
        # Get mapping for this file
        mapping_value, is_explicit = self.config.get_mapping(source_file, module_name)
        
        if is_explicit and mapping_value:
            # Check if it's a sentinel value
            if mapping_value.lower() in ('ignore', 'skip'):
                return [], True, 'ignore'
            
            # Check if it's a multi-destination mapping (comma-separated)
            if ',' in mapping_value:
                destinations = []
                for spec in mapping_value.split(','):
                    spec = spec.strip()
                    if spec:
                        destinations.append(self.config.expand_xdg_path(spec))
                return destinations, True, mapping_value
            
            # Single destination  mapping
            return [self.config.expand_xdg_path(mapping_value)], True, mapping_value
        
        # No explicit mapping - use default_action
        return self._apply_default_action(source_file), False, self.config.default_action
    
    def _apply_default_action(self, source_file: str) -> List[Path]:
        """
        Apply default action to determine destination.
        
        Args:
            source_file: Relative path of file within module
        
        Returns:
            List with single destination Path
        """
        basename = Path(source_file).name
        
        if self.config.default_action == 'dotify':
            # Add dot prefix if not already present
            if basename.startswith('.'):
                dest_name = basename
            else:
                dest_name = f'.{basename}'
            return [self.config.target / dest_name]
        
        elif self.config.default_action == 'home':
            # Install to home without modification
            return [self.config.target / basename]
        
        elif self.config.default_action == 'error':
            # Signal that unmapped files should error
            return []
        
        else:
            # Unknown action, default to dotify
            if basename.startswith('.'):
                dest_name = basename
            else:
                dest_name = f'.{basename}'
            return [self.config.target / dest_name]
    
    def should_ignore(self, source_file: str, module_name: str) -> bool:
        """
        Check if a file should be ignored (not installed).
        
        Args:
            source_file: Relative path of file within module
            module_name: Name of the module
        
        Returns:
            True if file should be ignored
        """
        destinations, is_explicit, action = self.resolve_destination(source_file, module_name)
        return len(destinations) == 0 or action == 'ignore'
    
    def expand_multi_destination(self, mapping_value: str) -> List[Path]:
        """
        Expand a multi-destination mapping (comma-separated).
        
        Args:
            mapping_value: Mapping value that may contain comma-separated destinations
        
        Returns:
            List of expanded Path objects
        """
        destinations = []
        for spec in mapping_value.split(','):
            spec = spec.strip()
            if spec and spec not in ('ignore', 'skip'):
                destinations.append(self.config.expand_xdg_path(spec))
        return destinations
