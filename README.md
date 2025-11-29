````markdown
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

### Nota sobre cambios a nivel sistema
Los instaladores incluidos (`scripts/install.sh` y `scripts/install.ps1`) aplican únicamente dotfiles de usuario (en `$HOME`) y **no** modifican archivos de sistema (`/etc/*`) de forma automática. Si necesitas aplicar configuraciones de sistema (por ejemplo, archivos de `X11`), sigue las instrucciones manuales en `docs/INSTALL.md`.

## Hooks Git
Este repositorio incluye un pre-commit hook en `.githooks/` que marca archivos con `shebang` como ejecutables en el índice al hacer commit para evitar problemas en entornos Unix.

- Activación automática: los instaladores (`scripts/install.sh` y `scripts/install.ps1`) configuran `core.hooksPath` a `.githooks` para la copia local del repo cuando se ejecutan (esta operación es idempotente y segura). Si prefieres hacerlo manualmente, ejecuta:
```bash
./scripts/setup-githooks.sh
```
- Para revertir la configuración en tu copia local:
```bash
git config --unset core.hooksPath
```

## Desarrollo y contribuciones
- Pull requests: bienvenidas. Haz PRs pequeños y fáciles de revisar.
- Issues: usa GitHub Issues para reportar errores o proponer mejoras.

## Licencias
Revisa `CC-SA-4.0` y `GPL-2.0` en la raíz del repositorio; hay archivos con diferentes licencias, revisa los archivos individuales si es necesario.

## Notas sobre Git LFS
Este repositorio usa Git LFS para recursos grandes (por ejemplo, `assets/poni`). Antes de clonar o trabajar con estos assets, asegúrate de tener `git-lfs` instalado y ejecutado.

## Contacto
Si tienes preguntas o sugerencias, abre un issue o contacta al mantenedor (ver perfil `JotaRandom` en GitHub).

````
**Dotfiles**

Breve colección de configuraciones, ajustes y archivos de configuración personalizados usados por mí en varias máquinas (laptops antiguas y nuevas). El repositorio agrupa dotfiles para diferentes equipos y entornos, junto con extras y notas históricas.

**One-line Quick Start (Linux / WSL)**
Para clonar, preparar y aplicar la configuración en una sola línea (Linux / WSL):
```bash
git clone --recurse-submodules https://github.com/JotaRandom/dotfiles.git ~/dotfiles && cd ~/dotfiles && git lfs install && git lfs pull && git submodule update --init --recursive && ./scripts/install.sh
```

**One-line Quick Start (PowerShell / Windows)**
Para clonar, preparar y aplicar la configuración en una sola línea (PowerShell):
```powershell
git clone https://github.com/JotaRandom/dotfiles.git $HOME\dotfiles; cd $HOME\dotfiles; git lfs install; git lfs pull; git submodule update --init --recursive; .\scripts\install.ps1
```

Lee `docs/INSTALL.md` si necesitas más detalle o alternativas (stow, configuraciones por distro, o ajustes manuales).

**Estructura**
- **`modules/`**: módulos de dotfiles por función listos para usar con `stow` (ej. `modules/shell/bash`, `modules/desktop/xfce`, `modules/system/etc`).
- **`machines/`**: archivos específicos por máquina (histórico) — ahora incluye `machines/L420` (mi máquina actual) y `machines/Toshiba` (antigua).
- **`assets/`**: recursos multimedia y binarios (por ejemplo `assets/poni` con imágenes de `ponysay`).
- **`distros/`**: configuraciones ajustadas por distribución (PopOS, PKGBUILD, etc.).
	- **`distros/PKGBUILD/`**: algunas carpetas de PKGBUILD se mantienen como submodules apuntando a sus repos en AUR; revisa `docs/CONTRIBUTING.md` para instrucciones sobre cómo actualizar.
- **`CC-SA-4.0`**, **`GPL-2.0`**: Archivos de licencia presentes en la raíz del repositorio.

**Descripción rápida**
- **Propósito**: Guardar y versionar configuraciones útiles (por ejemplo, `.bashrc`, `.zshrc`, archivos de `X11`, `udev`, `modprobe.d`, etc.) para poder replicarlas o consultarlas en el futuro.
- **Alcance**: Incluye configuraciones activas y antiguas. Algunas carpetas son históricas y se mantienen por referencia.

**Instalación y uso**
- **Clonar el repositorio**:
	- Linux/macOS: `git clone https://github.com/JotaRandom/dotfiles.git ~/dotfiles`
	- Windows PowerShell: `git clone https://github.com/JotaRandom/dotfiles.git $HOME\dotfiles`
- **Desplegar dotfiles (ejemplos)**:
	- Con `stow` (recomendado en sistemas Unix):
		1. `cd ~/dotfiles`
		2. `stow modules/shell/bash` (por ejemplo `stow modules/shell/bash` para enlazar `.bashrc` al `$HOME`).
	- Enlace manual (Linux/macOS): `ln -s ~/dotfiles/.bashrc ~/.bashrc`.
	- Enlace manual (PowerShell, requiere permisos/Developer Mode): `New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\\.bashrc" -Target "$pwd\\.bashrc"`

**Notas importantes**
- **Symlinks en Windows**: Crear enlaces simbólicos en Windows puede requerir permisos de administrador o activar el modo desarrollador.
- **Archivos históricos**: Algunas carpetas (por ejemplo `Toshiba/`) están aquí solo como referencia y no todas las configuraciones están garantizadas para funcionar en hardware moderno.
 - **Archivos históricos**: Las máquinas antiguas (por ejemplo `machines/Toshiba`) se encuentran en `machines/` como referencia. Para despliegue, utiliza los módulos en `modules/`.

**Preparar el repositorio (checklist rápido)**
- Clona y prepara submodules y LFS:
	```bash
	git clone --recurse-submodules https://github.com/JotaRandom/dotfiles.git ~/dotfiles
	cd ~/dotfiles
	git lfs install
	git lfs pull
	git submodule update --init --recursive
	```
- Instala dotfiles (stow / scripts):
	```bash
	./scripts/install.sh            # Unix/WSL (usa stow)
	.\scripts\install.ps1         # PowerShell (Windows - ejecutar con permisos si requiere symlinks)
	```
- Opcional: actualizar PKGBUILD submodules (todos o un paquete específico):

			opciones manuales:
			- Xorg (recomendado para X11): copia los archivos relevantes desde `modules/system/etc/X11/` a `/etc/X11/xorg.conf.d/`.
	```bash
	./scripts/update-submodules.sh           # Actualiza todos los submodules
	./scripts/update-submodules.sh micropolis-java  # Actualiza solo micropolis-java
	```

	- Xorg (recomendado para X11): copia `modules/system/etc/X11/+.conf` a `/etc/X11/xorg.conf.d/` y reinicia la sesión gráfica para aplicar los cambios.

	 Revisa `docs/INSTALL.md` para más detalles e instrucciones manuales.


Para más detalles y alternativas (subtree, CI, etc), revisa `docs/INSTALL.md` y `docs/CONTRIBUTING.md`.

**Quick start — Reinstalación**
	```bash
	git clone https://github.com/JotaRandom/dotfiles.git ~/dotfiles
	cd ~/dotfiles
	git lfs install
	git lfs pull
	./scripts/install.sh
	# o especifica los módulos que quieres aplicar:
	./scripts/install.sh modules/shell/bash modules/shell/fish modules/editor/nvim modules/editor/vscode
	```
Nota: El instalador `./scripts/install.sh` aplica solo dotfiles de usuario en `$HOME` (stow), y no modifica archivos de sistema como `/etc/*`. Para cambios a nivel sistema aplica los archivos manualmente con permisos root según las instrucciones en `docs/INSTALL.md`.

Desarrolladores: Los instaladores `scripts/install.sh` y `scripts/install.ps1` configuran automáticamente `core.hooksPath` a `.githooks`
en tu copia local del repositorio cuando se ejecutan (esto es seguro y idempotente). Si prefieres configurarlo manualmente en vez de
ejecutar el instalador, puedes correr:

```bash
./scripts/setup-githooks.sh
```

Esto configurará `core.hooksPath` a `.githooks` para esta copia local del repo y activará el pre-commit que ajusta el bit ejecutable en archivos dentro de `scripts/`.
	```powershell
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
