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
   # Clonar también los submodules (PKGBUILD):
   git submodule update --init --recursive
   ```
2. Instalar dependencias (ej. stow):
   - Debian/Ubuntu: `sudo apt install stow git-lfs`
   - Arch: `sudo pacman -S stow git-lfs`
3. Usar `scripts/install.sh` para aplicar los módulos por defecto o elige módulos concretos:
   ```bash
   cd ~/dotfiles
   ./scripts/install.sh modules/shell/bash modules/shell/fish modules/editor/nvim modules/editor/vscode
   ```
   - Para instalar la configuración de teclado `latam` vía Xorg InputClass (recomendado):
      ```bash
   Copia `modules/system/etc/X11/90-latin-keyboard.conf` a `/etc/X11/xorg.conf.d/` y reinicia la sesi�n gráfica.
      ```
4. (Opcional) si usas Windows, usa `scripts/install.ps1` en PowerShell ejecutándolo como administrador para crear symlinks a partir de los módulos.

Precauciones:
- Si tienes archivos existentes en `$HOME`, el instalador no los sobrescribirá y te avisará. Haz backup de configuraciones importantes antes de ejecutar.

## Auto-setup teclado Latin American (opcional, Xorg / hwdb)
Si mantienes archivos de sistema con este repo y deseas que el layout de teclado `latam` o un remapeo por hardware se aplique automáticamente, sigue estas opciones (requiere privilegios de root):

### Opción A: Xorg InputClass (recomendado para X11)
1. Copiar `modules/system/etc/X11/90-latin-keyboard.conf` a `/etc/X11/xorg.conf.d/`.
2. Reinicia la sesi�n gráfica tras copiar el archivo a /etc/X11/xorg.conf.d/.
2. Reiniciar la sesión gráfica.

### Opción B: hwdb (udev-based, remapeo scancode -> keycode, aplica a X11 y Wayland)
1. Añadir (o personalizar) el archivo `modules/system/etc/udev/hwdb.d/90-latin-layout.hwdb` con `evdev:` reglas y `KEYBOARD_KEY_*` mapeos para teclas específicas.
2. Ejecutar manualmente: `sudo systemd-hwdb update && sudo udevadm trigger`.
3. Copia `modules/system/etc/udev/hwdb.d/90-latin-layout.hwdb` a `/etc/udev/hwdb.d/` y ejecuta `sudo systemd-hwdb update && sudo udevadm trigger`.

La opción hwdb es la única manera sólida de lograr una configuración 100% udev-only sin usar scripts ni servicios que dependan de la sesión gráfica. Actúa en la capa del kernel (input map), por lo que se aplica tanto a Wayland como a X11.

