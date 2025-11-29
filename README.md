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
# dotfiles

Colección personal de configuraciones y dotfiles para distintas máquinas y entornos. Aquí se agrupan módulos de configuración, archivos históricos y extras organizados para ser fáciles de desplegar con `stow` (en Unix) o mediante scripts en Windows.

## Inicio rápido (Linux / WSL)
Clona y aplica la configuración (todas las dependencias y submodules) en una sola línea:
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

Lee `docs/INSTALL.md` para instrucciones detalladas (stow, opciones por distro y pasos manuales).

## Estructura del repositorio
- `modules/`: módulos de dotfiles por función (ej.: `modules/shell/bash`, `modules/editor/nvim`).
- `machines/`: configuraciones y archivos específicos por equipo (referencia histórica).
- `assets/`: recursos multimedia y binarios (manejados con Git LFS).
- `distros/`: configuraciones por distribución y submodules con PKGBUILD.
- `scripts/`: scripts de utilidad (instaladores, actualización de submodules, setup de hooks, etc.).

## Propósito
Guardar y versionar configuraciones (dotfiles), snippets y archivos de configuración que uso en distintas máquinas o que sirven como referencia. Algunas carpetas contienen material histórico y ejemplos para hardware concreto.

## Instalación y uso
1. Clona el repositorio y prepara submodules y LFS (ver inicio rápido arriba).
2. Instala dependencias necesarias (por ejemplo `stow` en Linux):
   - Debian/Ubuntu: `sudo apt install stow git-lfs`
   - Arch: `sudo pacman -S stow git-lfs`
3. Aplica los módulos que necesites con `stow` o usa los instaladores:
   ```bash
   ./scripts/install.sh modules/shell/bash modules/editor/nvim
   ```
   En Windows (PowerShell):
   ```powershell
   .\scripts\install.ps1 modules/shell/bash
   ```

### Nota sobre cambios a nivel sistema
Los instaladores incluidos (`scripts/install.sh` y `scripts/install.ps1`) solo aplican dotfiles de usuario en `$HOME` y **no** modifican archivos de sistema (`/etc/*`). Para aplicar archivos del sistema, sigue las instrucciones manuales en `docs/INSTALL.md`.

## Hooks Git
Incluimos ganchos locales en `.githooks` para mantener el índice consistente (los hooks marcan como ejecutables los archivos con shebang al hacer commit).

- Activación automática: los instaladores (`scripts/install.sh` y `scripts/install.ps1`) configuran `core.hooksPath` a `.githooks` en tu clon local (idempotente y seguro).
- Activación manual: `./scripts/setup-githooks.sh` (o `./scripts/setup-githooks.ps1` en PowerShell).
- Revertir: `git config --unset core.hooksPath`.

Si necesitas ejecutar el instalador en PowerShell con la política de ejecución adecuada:
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
.\scripts\install.ps1 modules/shell/bash
```

## Contribuir
- Pull requests bienvenidas; por favor, haz PRs pequeños y fáciles de revisar.
- Usa GitHub Issues para bugs, dudas o propuestas.

## Licencia
Revisa `CC-SA-4.0` y `GPL-2.0` en la raíz del repositorio. Algunos archivos pueden indicar licencias diferentes; consúltalos individualmente.

## Git LFS
Este repo usa Git LFS para archivos grandes (por ejemplo `assets/poni`). Instala `git-lfs` y ejecuta `git lfs install` tras clonar para evitar problemas.

## Contacto
Si tienes preguntas o sugerencias, abre un issue o contacta al mantenedor (perfil `JotaRandom` en GitHub).
# dotfiles

Colección personal de configuraciones y dotfiles para distintas máquinas y entornos. Aquí se agrupan módulos de configuración, archivos históricos y extras organizados para ser fáciles de desplegar con `stow` (en Unix) o mediante scripts en Windows.

## Inicio rápido (Linux / WSL)
Clona y aplica la configuración (todas las dependencias y submodules) en una sola línea:
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

Lee `docs/INSTALL.md` para instrucciones detalladas (stow, opciones por distro y pasos manuales).

## Estructura del repositorio
- `modules/`: módulos de dotfiles por función (ej.: `modules/shell/bash`, `modules/editor/nvim`).
- `machines/`: configuraciones y archivos específicos por equipo (referencia histórica).
- `assets/`: recursos multimedia y binarios (manejados con Git LFS).
- `distros/`: configuraciones por distribución y submodules con PKGBUILD.
- `scripts/`: scripts de utilidad (instaladores, actualización de submodules, setup de hooks, etc.).

## Propósito
Guardar y versionar configuraciones (dotfiles), snippets y archivos de configuración que uso en distintas máquinas o que sirven como referencia. Algunas carpetas contienen material histórico y ejemplos para hardware concreto.

## Instalación y uso
1. Clona el repositorio y prepara submodules y LFS (ver inicio rápido arriba).
2. Instala dependencias necesarias (por ejemplo `stow` en Linux):
   - Debian/Ubuntu: `sudo apt install stow git-lfs`
   - Arch: `sudo pacman -S stow git-lfs`
3. Aplica los módulos que necesites con `stow` o usa los instaladores:
   ```bash
   ./scripts/install.sh modules/shell/bash modules/editor/nvim
   ```
   En Windows (PowerShell):
   ```powershell
   .\scripts\install.ps1 modules/shell/bash
   ```

### Nota sobre cambios a nivel sistema
Los instaladores incluidos (`scripts/install.sh` y `scripts/install.ps1`) solo aplican dotfiles de usuario en `$HOME` y **no** modifican archivos de sistema (`/etc/*`). Para aplicar archivos del sistema, sigue las instrucciones manuales en `docs/INSTALL.md`.

## Hooks Git
Incluimos ganchos locales en `.githooks` para mantener el índice consistente (los hooks marcan como ejecutables los archivos con shebang al hacer commit).

- Activación automática: los instaladores (`scripts/install.sh` y `scripts/install.ps1`) configuran `core.hooksPath` a `.githooks` en tu clon local (idempotente y seguro).
- Activación manual: `./scripts/setup-githooks.sh` (o `./scripts/setup-githooks.ps1` en PowerShell).
- Revertir: `git config --unset core.hooksPath`.

Si necesitas ejecutar el instalador en PowerShell con la política de ejecución adecuada:
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
.\scripts\install.ps1 modules/shell/bash
```

## Contribuir
- Pull requests bienvenidas; por favor, haz PRs pequeños y fáciles de revisar.
- Usa GitHub Issues para bugs, dudas o propuestas.

## Licencia
Revisa `CC-SA-4.0` y `GPL-2.0` en la raíz del repositorio. Algunos archivos pueden indicar licencias diferentes; consúltalos individualmente.

## Git LFS
Este repo usa Git LFS para archivos grandes (por ejemplo `assets/poni`). Instala `git-lfs` y ejecuta `git lfs install` tras clonar para evitar problemas.

## Contacto
Si tienes preguntas o sugerencias, abre un issue o contacta al mantenedor (perfil `JotaRandom` en GitHub).
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
