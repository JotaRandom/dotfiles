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


### Opción A: Xorg InputClass (recomendado para X11)
1. Copiar `modules/system/etc/X11/*.conf` a `/etc/X11/xorg.conf.d/`.
2. Reinicia la sesión gráfica tras copiar el archivo a /etc/X11/xorg.conf.d/.

## Hooks Git (Opcional)
Este repositorio incluye un hook pre-commit en `.githooks/pre-commit` que asegura que los archivos dentro
de `scripts/` con un shebang (`#!`) reciban el bit de ejecución (`+x`) en el índice al hacer commit, para evitar
problemas en plataformas Unix. Para activar los hooks en tu copia local ejecuta:

```bash
./scripts/setup-githooks.sh
```

Después de ejecutar el script, el hook correrá localmente antes de cada commit. Si deseas revertir este cambio:
```bash
git config --unset core.hooksPath
```
