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
	```bash
	./scripts/update-submodules.sh           # Actualiza todos los submodules
	./scripts/update-submodules.sh micropolis-java  # Actualiza solo micropolis-java
	```

	**Auto-setup de teclado (Latin American)**
	Si deseas que el `layout` `latam` se aplique automáticamente cuando conectas un teclado, tienes dos opciones según el entorno:

	- Xorg (recomendado para X11): usa `./scripts/install.sh --xorg`. Esto instala un `InputClass` para Xorg que establece `XkbLayout` a `latam` para teclados.
	- hwdb / udev (recomendado para Wayland o si quieres una solución a nivel kernel): copia `modules/system/etc/udev/hwdb.d/90-latin-layout.hwdb` y corre `sudo systemd-hwdb update && sudo udevadm trigger`, o usa `./scripts/install.sh --hwdb`.

	 Revisa `docs/INSTALL.md` para más detalles e instrucciones manuales.


Para más detalles y alternativas (subtree, CI, etc), revisa `docs/INSTALL.md` y `docs/CONTRIBUTING.md`.

**Quick start — Reinstalación**
- Para preparar y aplicar tu configuración tras reinstalar un sistema Linux/WSL:
	```bash
	git clone https://github.com/JotaRandom/dotfiles.git ~/dotfiles
	cd ~/dotfiles
	git lfs install
	git lfs pull
	./scripts/install.sh
	# o especifica los módulos que quieres aplicar:
	./scripts/install.sh modules/shell/bash modules/shell/fish modules/editor/nvim modules/editor/vscode
	```
- En Windows, preferiblemente usa WSL o ejecuta `scripts/install.ps1` con permisos de administrador:
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
