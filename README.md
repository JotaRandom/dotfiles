# dotfiles

Colección de configuraciones (dotfiles) que uso en varias máquinas y entornos. Este repositorio agrupa módulos organizados para facilitar su despliegue mediante `stow` (Unix) y scripts de ayuda (Windows).

## Inicio rápido — Linux / WSL
```bash
git clone --recurse-submodules https://github.com/JotaRandom/dotfiles.git ~/dotfiles
cd ~/dotfiles
git lfs install
git lfs pull
git submodule update --init --recursive
./scripts/install.sh
```

## Inicio rápido — PowerShell / Windows
```powershell
git clone https://github.com/JotaRandom/dotfiles.git $HOME\dotfiles
cd $HOME\dotfiles
git lfs install
git lfs pull
git submodule update --init --recursive
.\scripts\install.ps1
```

Para instrucciones más detalladas revisa `docs/INSTALL.md`.

## Estructura
- `modules/`: módulos por función (e.g. `modules/shell/bash`).
- `machines/`: configuraciones históricas específicas de hardware.
- `assets/`: binarios y recursos multimedia (Git LFS).
- `distros/`: configuraciones por distribución y submodules (PKGBUILD).
- `scripts/`: scripts de utilidad (instalador, githooks, actualización de submodules).

## Propósito
Guardar y versionar configuraciones, dotfiles y snippets que faciliten el despliegue y la configuración de entornos.

## Instalación y uso
1. Prepara el repositorio (submodules + LFS):
```bash
git clone --recurse-submodules https://github.com/JotaRandom/dotfiles.git ~/dotfiles
cd ~/dotfiles
git lfs install
git lfs pull
git submodule update --init --recursive
```
2. Instala dependencias (ej. `stow` en Linux): Debian/Ubuntu: `sudo apt install stow git-lfs` — Arch: `sudo pacman -S stow git-lfs`.
3. Aplica módulos con `stow` o usa el instalador:
```bash
./scripts/install.sh modules/shell/bash modules/editor/nvim
```
En Windows (PowerShell):
```powershell
.\scripts\install.ps1 modules/shell/bash
```

### Nota sobre cambios a nivel sistema
Los instaladores incluidos solo aplican dotfiles de usuario en `$HOME`. No se modifican archivos de sistema (`/etc/*`) automáticamente. Para aplicar archivos de sistema, sigue las instrucciones manuales en `docs/INSTALL.md`.

## Hooks Git
El repositorio incluye hooks en `.githooks` que, por ejemplo, marcan archivos con shebang como ejecutables en el índice.
- Activación automática: los instaladores configuran `core.hooksPath` a `.githooks` en tu clon local (idempotente).
- Activación manual: `./scripts/setup-githooks.sh` (o `setup-githooks.ps1`).
- Revertir: `git config --unset core.hooksPath`.

## Contribuir
- Pull requests y Issues bienvenidos. Prevén PRs pequeños y fáciles de revisar.

## Licencia
Revisa `CC-SA-4.0` y `GPL-2.0` en la raíz del repo para detalles.

## Notas sobre Git LFS
Instala `git-lfs` antes de trabajar con los assets (ej.: `assets/poni`) si clonas el repo.

## Contacto
Abre un issue o contacta al mantenedor (perfil `JotaRandom` en GitHub).
