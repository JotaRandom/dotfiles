Guía rápida de instalación y despliegue (reinstalación de sistema)

Requisitos:
- Git
- Git LFS (si clonarás los assets)
- GNU Stow (Linux/Unix)

Pasos para reinstalar y aplicar tu configuración (Linux, WSL):
1. Clona el repo y habilita LFS:
   ```bash
   git clone https://github.com/JotaRandom/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   git lfs install
   git lfs pull
   ```
2. Instalar dependencias (ej. stow):
   - Debian/Ubuntu: `sudo apt install stow git-lfs`
   - Arch: `sudo pacman -S stow git-lfs`
3. Usar `scripts/install.sh` para aplicar los módulos por defecto o elige módulos concretos:
   ```bash
   cd ~/dotfiles
   ./scripts/install.sh modules/shell/bash modules/tmux
   ```
4. (Opcional) si usas Windows, usa `scripts/install.ps1` en PowerShell ejecutándolo como administrador para crear symlinks a partir de los módulos.

Precauciones:
- Si tienes archivos existentes en `$HOME`, el instalador no los sobrescribirá y te avisará. Haz backup de configuraciones importantes antes de ejecutar.
