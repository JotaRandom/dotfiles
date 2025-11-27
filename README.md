**Dotfiles**

Breve colección de configuraciones, ajustes y archivos de configuración personalizados usados por mí en varias máquinas (laptops antiguas y nuevas). El repositorio agrupa dotfiles para diferentes equipos y entornos, junto con extras y notas históricas.

**Estructura**
- **`L420/`**: Configuraciones y archivos relacionados con mi Lenovo ThinkPad L420.
- **`Toshiba/`**: Copias históricas de configuraciones de un Toshiba antiguo (archivos de referencia, `dsdt.dsl`, etc.).
- **`PopOS/`**, **`PKGBUILD/`**, **`etc/`**, **`usr/`**: Configs para distintas distribuciones, paquetes y ajustes de sistema.
- **`Poni/`**: Imágenes y recursos creados o adaptados para `ponysay` (ver `Poni/` para detalles sobre autores y licencias de cada imagen).
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
		2. `stow <carpeta>` (por ejemplo `stow L420` para enlazar los archivos al `$HOME`).
	- Enlace manual (Linux/macOS): `ln -s ~/dotfiles/.bashrc ~/.bashrc`.
	- Enlace manual (PowerShell, requiere permisos/Developer Mode): `New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\\.bashrc" -Target "$pwd\\.bashrc"`

**Notas importantes**
- **Symlinks en Windows**: Crear enlaces simbólicos en Windows puede requerir permisos de administrador o activar el modo desarrollador.
- **Archivos históricos**: Algunas carpetas (por ejemplo `Toshiba/`) están aquí solo como referencia y no todas las configuraciones están garantizadas para funcionar en hardware moderno.

**Contribuir**
- **Pull requests**: Bienvenidas pequeñas mejoras, correcciones de ortografía y actualización de notas.
- **Issues**: Usa GitHub Issues para reportar errores en los scripts o para preguntar sobre cómo desplegar algo en un entorno específico.

**Licencia**
- Este repositorio contiene archivos bajo distintas licencias; revisa `CC-SA-4.0` y `GPL-2.0` en la raíz. Además, revisa cualquier archivo individual que incluya un aviso de copyright.

**Contacto**
- Para preguntas o sugerencias, abre un issue en este repositorio o contacta al mantenedor (ver perfil de GitHub `JotaRandom`).
