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

### Notas sobre `install.ps1` y paridad con `install.sh`

El instalador de PowerShell (`scripts/install.ps1`) está alineado con `scripts/install.sh` en comportamiento:

- Respeta las entradas de `install-mappings.yml` (globales y por módulo) y crea enlaces simbólicos en XDG/HOME.
- Crea backups de archivos conflictivos en `$HOME/.dotfiles_backup/<timestamp>/` antes de reemplazar.
- Soporta el parámetro `-Target` para sandbox (`-Target $env:TEMP\dotfiles_test`) y `-Modules` para seleccionar módulos.
- Implementa saneamiento CRLF → LF para archivos interactivos (ver sección "Saneamiento de finales de línea").

> Nota: En Windows, la creación de enlaces simbólicos puede requerir privilegios administrativos o activar Developer Mode. Si te faltan permisos, ejecuta PowerShell como administrador o habilita Developer Mode.


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

### Saneamiento de finales de línea (CRLF → LF)

Algunos archivos de shell interactivo (p. ej. `.bashrc`, `.zshrc`, `.profile`) tienen finales de línea en formato Windows (CRLF) en ciertos editores o repositorios. Esto puede causar errores en shells Unix/WSL al interpretar `$'\r'` o producir `syntax error` por `
` en scripts.

Los instaladores `scripts/install.sh` y `scripts/install.ps1` detectan los archivos interactivos con CRLF y, en lugar de modificar el repositorio, crean una copia saneada con LF en:

```
$TARGET/.dotfiles_sanitized/<module>/<path>
```

Los enlaces simbólicos apuntan a esa copia saneada. Esto asegura que los entornos de usuario no se rompan por finales de línea CRLF y evita cambiar archivos en el repo por defecto.

Si prefieres normalizar el repo en origen a LF de manera permanente, puedes hacerlo manualmente o solicitar la característica `--normalize` para convertir archivos en repo (no habilitado por defecto).


#### Restaurar archivos respaldados
Si necesitas restaurar archivos desde un backup creado por el instalador, copia los archivos de vuelta desde `$HOME/.dotfiles_backup/<timestamp>/` a tu home. Por ejemplo:
```bash
cp -a "$HOME/.dotfiles_backup/<timestamp>/." "$HOME/"
```
Ten cuidado: esto sobrescribirá los archivos actuales. Verifica el contenido del backup antes de restaurar.

### Opcional: script de restauración
Para facilitar la restauración, puedes usar los scripts de ayuda incluidos:
 - Bash: `scripts/restore-backup.sh <timestamp> <module>`
 - PowerShell: `scripts/restore-backup.ps1 -Timestamp <timestamp> -Module <module>`
Sin argumentos, estos scripts listan los backups y módulos disponibles. Solicitan confirmación antes de restaurar y tratan de preservar los archivos existentes cuando es posible.
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

## CI y submódulos

Detalles sobre el tratamiento de submódulos SSH por el CI se encuentran en `docs/CI.md`. El flujo de CI **no intentará** actualizar o clonar submódulos privados: solo comprobará que `.gitmodules` contiene entradas válidas y seguirá sin error en runners públicos.

Además, el pipeline de CI incluye pruebas de instalación y verificación automatizadas:

- `stow-test`: aplica cada módulo con `stow` a un `TARGET` temporal para verificar que se creen symlinks sin tocar `$HOME`.
- `test-install-mappings.sh`: ejecuta `install.sh` en un `TARGET` temporal y valida que todas las entradas declaradas en `install-mappings.yml` se hayan instalado como symlinks apuntando al origen, o que hayan producido copias saneadas en `$TARGET/.dotfiles_sanitized` si el origen contenía CRLF.

