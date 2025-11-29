# dotfiles
Colección personal de configuraciones y dotfiles para distintas máquinas y entornos. Aquí se agrupan módulos de configuración, archivos históricos y extras organizados para ser fáciles de desplegar con `stow` (en Unix) o mediante scripts en Windows.

## Inicio rápido (Linux / WSL)
Clona y aplica la configuración en una sola línea:
```bash
git clone --recurse-submodules https://github.com/JotaRandom/dotfiles.git ~/dotfiles
cd ~/dotfiles
git lfs install
git lfs pull
git submodule update --init --recursive
./scripts/install.sh
```

## Inicio rápido (PowerShell / Windows)
```powershell
git clone https://github.com/JotaRandom/dotfiles.git $HOME\dotfiles
cd $HOME\dotfiles
git lfs install
git lfs pull
git submodule update --init --recursive
.\scripts\install.ps1
```

Lee `docs/INSTALL.md` para instrucciones detalladas, alternativas y ejemplos por distribución.

## Estructura del repositorio
- `modules/`: módulos de dotfiles por función. Ej: `modules/shell/bash`, `modules/editor/nvim`.
- `machines/`: configuraciones y archivos específicos por equipo (referencia histórica).
- `assets/`: recursos multimedia y archivos binarios (se manejan con Git LFS).
- `distros/`: configuraciones por distro y submodules de PKGBUILD.
- `scripts/`: scripts de utilidad (instaladores, actualizaciones, githooks).

## Propósito
Este repositorio sirve como un lugar para guardar y versionar configuraciones (dotfiles), snippets, y archivos de configuración que se usan en mis equipos o que pueden servir como referencia. Algunas carpetas contienen material histórico o configuraciones destinadas a máquinas concretas.
## Instalación y uso
# dotfiles
1. Clona el repositorio y prepara submodules y LFS (ver inicio rápido).
2. Instala dependencias necesarias (por ejemplo `stow` en Linux):
   - Debian/Ubuntu: `sudo apt install stow git-lfs`
   - Arch: `sudo pacman -S stow git-lfs`
3. Aplica los módulos que necesites con `stow` o usa los instaladores:
   ```bash
   ./scripts/install.sh modules/shell/bash modules/editor/nvim
   ```
   En Windows:
   ```powershell
   .\scripts\install.ps1 modules/shell/bash
   ```
Nota: El instalador `./scripts/install.sh` aplica solo dotfiles de usuario en `$HOME` (stow), y no modifica archivos de sistema como `/etc/*`. Para cambios a nivel sistema aplica los archivos manualmente con permisos root según las instrucciones en `docs/INSTALL.md`.

Desarrolladores: Los instaladores `scripts/install.sh` y `scripts/install.ps1` configuran automáticamente `core.hooksPath` a `.githooks`
en tu copia local del repositorio cuando se ejecutan (esto es seguro y idempotente). Si prefieres configurarlo manualmente en vez de
ejecutar el instalador, puedes correr:

```bash
./scripts/setup-githooks.sh
```

Esto configurará `core.hooksPath` a `.githooks` para esta copia local del repo y activará el pre-commit que ajusta el bit ejecutable en archivos dentro de `scripts/`.
Lee `docs/INSTALL.md` para instrucciones detalladas, alternativas y ejemplos por distribución.
	Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
	.\scripts\install.ps1 modules/shell/bash
	```

**Contribuir**
- **Pull requests**: Bienvenidas pequeñas mejoras, correcciones de ortografía y actualización de notas.
- **Issues**: Usa GitHub Issues para reportar errores en los scripts o para preguntar sobre cómo desplegar algo en un entorno específico.

**Licencia**
- Este repositorio contiene archivos bajo distintas licencias; revisa `CC-SA-4.0` y `GPL-2.0` en la raíz. Además, revisa cualquier archivo individual que incluya un aviso de copyright.

**Notas sobre Git LFS**
- Este repositorio usa Git LFS para almacenar archivos binarios grandes (por ejemplo las imágenes en `assets/poni`). Si clonas el repo, instala Git LFS y corre `git lfs install` antes de clonar para evitar problemas con archivos binarios.


**Contacto**
- Para preguntas o sugerencias, abre un issue en este repositorio o contacta al mantenedor (ver perfil de GitHub `JotaRandom`).
