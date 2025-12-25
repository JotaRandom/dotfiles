# Font Requirements for Dotfiles

This document lists the fonts required and recommended for the dotfiles configuration.

## Required Fonts

### DejaVu Sans Mono
Primary monospace font used across all terminal emulators and code editors.

**Installation:**
- **Arch Linux**: `sudo pacman -S ttf-dejavu`
- **Debian/Ubuntu**: `sudo apt install fonts-dejavu`
- **Fedora/RHEL**: `sudo dnf install dejavu-sans-mono-fonts`

**Used in:**
- Alacritty terminal
- Kitty terminal
- VSCode editor
- Sublime Text editor
- labwc window manager (UI elements)
- waybar taskbar

## Recommended Fonts

### Liberation Mono
Fallback font, metrics-compatible with Courier New.

**Installation:**
- **Arch Linux**: `sudo pacman -S ttf-liberation`
- **Debian/Ubuntu**: `sudo apt install fonts-liberation`
- **Fedora/RHEL**: `sudo dnf install liberation-mono-fonts`

### Noto Sans Mono
Fallback font with excellent Unicode coverage.

**Installation:**
- **Arch Linux**: `sudo pacman -S noto-fonts`
- **Debian/Ubuntu**: `sudo apt install fonts-noto`
- **Fedora/RHEL**: `sudo dnf install google-noto-sans-mono-fonts`

## Automatic Font Installation

The installer (`scripts/install.py`) automatically checks for required fonts when installing terminal or editor modules:

```bash
# Install dotfiles (will check fonts automatically)
python scripts/install.py install

# Check fonts manually
python scripts/dotfiles_installer/fonts.py

# Check and install optional fonts too
python scripts/dotfiles_installer/fonts.py --optional

# Non-interactive mode (auto-install)
python scripts/dotfiles_installer/fonts.py --non-interactive
```

## Manual Verification

To verify which fonts are installed on your system:

```bash
# List all installed fonts
fc-list

# Check for specific font
fc-list | grep -i "dejavu sans mono"

# Check which font is used for monospace
fc-match monospace
```

## Font Configuration

Font preferences are configured in:
- `modules/system/fontconfig/fonts.conf` - System-wide font configuration
- Individual application configs reference DejaVu Sans Mono directly

The fontconfig configuration prioritizes fonts in this order:
1. DejaVu Sans Mono
2. Liberation Mono
3. Noto Sans Mono

## Troubleshooting

### Font not appearing after installation

Rebuild the font cache:
```bash
fc-cache -fv
```

### Wrong font being used

Check fontconfig configuration:
```bash
fc-match monospace
```

If it's not showing DejaVu Sans Mono, verify the font is installed and fontconfig is properly configured.

### Font rendering issues

Ensure fontconfig is installed and configured:
```bash
# Arch Linux
sudo pacman -S fontconfig

# Debian/Ubuntu
sudo apt install fontconfig
```

## Why DejaVu Sans Mono?

DejaVu Sans Mono was chosen because:
- ✅ Excellent rendering quality on all displays
- ✅ Available in official repositories of all major distros
- ✅ Reliable character spacing and alignment
- ✅ Good Unicode coverage
- ✅ Appropriate for retro Windows 95/98 aesthetic
- ✅ Free and open source (Bitstream Vera derivative)

Previous font (Cascadia Code) had rendering issues with character overlap on some systems.
