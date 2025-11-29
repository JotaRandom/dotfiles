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

4. (Opcional) si usas Windows, usa `scripts/install.ps1` en PowerShell ejecutándolo como administrador para crear symlinks a partir de los módulos.

Precauciones:
- Si tienes archivos existentes en `$HOME`, el instalador no los sobrescribirá y te avisará. Haz backup de configuraciones importantes antes de ejecutar.

Nota sobre archivos de sistema:
- Este instalador solo aplica dotfiles de usuario en `$HOME`.
- Módulos que contienen archivos bajo `etc/` (por ejemplo `modules/system/etc/thinkfan.conf`) son considerados archivos a nivel sistema y **no serán aplicados** por `scripts/install.sh` para evitar que se instalen en ubicaciones como `/etc` inadvertidamente. Si deseas aplicar dichos archivos deberás copiarlos manualmente con permisos de root y siguiendo las instrucciones del módulo.

Nota sobre archivos de configuración XDG y archivos en el root del módulo
---------------------------------------------------------------
El instalador (`scripts/install.sh`) ahora mantiene la estructura de origen de los módulos (para que los dotfiles sigan centralizados en su ruta de origen dentro de `modules/`) y aplica ciertos archivos raíz a su ubicación XDG correcta automáticamente cuando corresponde. Esto evita mover archivos en el repositorio solo para adaptarlos a una convención de instalación.

Ejemplos de mapeos automáticos que el instalador maneja:
- `config.fish` → `~/.config/fish/config.fish`
- `init.vim` → `~/.config/nvim/init.vim`
- `settings.json` en el módulo `modules/editor/vscode` → `~/.config/Code/User/settings.json`

El instalador seguirá usando `stow` para el resto de los archivos en cada módulo. Si tu módulo contiene archivos a nivel sistema (`etc/`), el instalador los ignorará — debes aplicarlos manualmente con privilegios elevados si así lo deseas.


### Opción A: Xorg InputClass (recomendado para X11)
1. Copiar `modules/system/etc/X11/*.conf` a `/etc/X11/xorg.conf.d/`.
2. Reinicia la sesión gráfica tras copiar el archivo a /etc/X11/xorg.conf.d/.

## Hooks Git (automático)
Este repositorio incluye un pre-commit hook en `.githooks/pre-commit` que asegura que los archivos dentro
de `scripts/` con un shebang (`#!`) reciban el bit de ejecución (`+x`) en el índice al hacer commit, para evitar
problemas en plataformas Unix.

Los instaladores `scripts/install.sh` y `scripts/install.ps1` ejecutarán automáticamente `scripts/setup-githooks.*`
si se ejecutan en una copia del repositorio (es idempotente y seguro). Si prefieres configurarlo manualmente, ejecuta:

```bash
./scripts/setup-githooks.sh
```

Para revertir la configuración en tu copia local:
```bash
git config --unset core.hooksPath
```
