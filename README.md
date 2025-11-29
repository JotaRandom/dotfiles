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

### Nota sobre cambios a nivel sistema y conflictos
Los instaladores incluidos solo aplican dotfiles de usuario en `$HOME`. No se modifican archivos de sistema (`/etc/*`) automáticamente. Si al aplicar los módulos hay archivos conflictivos en `$HOME` (por ejemplo un `~/.bashrc` ya existente), el instalador preferirá los dotfiles del repositorio y respaldará los archivos anteriores en `$HOME/.dotfiles_backup/<timestamp>/` antes de reemplazarlos.
Para aplicar archivos de sistema (por ejemplo `X11`), sigue las instrucciones manuales en `docs/INSTALL.md`.

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

## ¿Cómo agregar un nuevo dotfile (módulo stow)?
Si quieres añadir un nuevo dotfile al repositorio usando `stow`, sigue estos pasos:

1) Crea un nuevo módulo bajo `modules/` con el nombre que prefieras (por ejemplo `modules/myapp`).
	- Los archivos deben replicar la estructura destino a partir del home del usuario; por ejemplo, si quieres añadir `~/.config/myapp/config.yml`, crea `modules/myapp/.config/myapp/config.yml`.
	- Para dotfiles que están directamente en el home (p. ej. `.bashrc`), coloca el fichero bajo `modules/mybash/.bashrc`.

2) Prueba localmente con `stow` antes de commitear:
```bash
cd modules
# Probar sin aplicar directamente (no-ops): stow -n -t $HOME myapp
# Para aplicar a un directorio temporal y verificar symlink real (reversible):
TMP=$(mktemp -d)
stow -v -t "$TMP" myapp
ls -l "$TMP"  # verifica symlinks/tablas creadas
rm -rf "$TMP"
```

3) Añade un `README` dentro de tu módulo si necesitas documentar opciones o dependencias especiales.

4) Asegúrate de que cualquier script que añadas tenga la shebang y el permiso de ejecución. Nuestro pre-commit hook y CI intentarán marcar archivos con `#!` como ejecutables en el índice.

5) Crea un PR explicando qué hace el módulo y cómo probarlo. En CI, hemos añadido una verificación (`stow-test`) que aplica todos los módulos en `modules/` a un target temporal y verifica que se creen symlinks; esto ayudará a detectar problemas en la estructura de módulos.

Consejo: Mantén los módulos pequeños y con un propósito único (p. ej. `modules/nvim` sólo para configuración de neovim), así es más fácil revisarlos y probarlos.
