
# dotfiles — Inicio rápido

Este repositorio contiene configuraciones (dotfiles) organizadas en módulos (`modules/`) y administradas mediante un instalador mapeado (`./scripts/install.sh`).

Guía rápida — pasos esenciales:

1) Clona el repo y prepara LFS/submódulos:

```bash
git clone --recurse-submodules https://github.com/JotaRandom/dotfiles.git ~/dotfiles
cd ~/dotfiles
git lfs install
git lfs pull
git submodule update --init --recursive
```

2) Ejecuta el instalador (Linux / WSL):

```bash
./scripts/install.sh modules/editor/nvim modules/shell/zsh
```

3) En Windows (PowerShell):

```powershell
./scripts/install.ps1 modules/editor/nvim modules/shell/zsh
```

Estructura breve del repo:

 - `modules/*`: Cada carpeta contiene un módulo con la estructura de archivos de destino (por ejemplo `modules/nvim/.config/nvim/init.vim`). Este instalador aplica symlinks directamente usando `install-mappings.yml` y sanea CRLFs y conflictos, lo que evita la creación accidental de archivos visibles en `$HOME`.
- `install-mappings.yml`: Reglas declarativas (XDG/HOME) que el instalador usa para colocar archivos en las rutas correctas.

Cómo funciona `install.sh` (explicado de forma muy simple):

- Piensa en cada módulo como una caja con la estructura relativa de destino para los archivos. `./scripts/install.sh` lee `install-mappings.yml` y crea symlinks deterministas en `$TARGET` (por defecto `~`).
- Si un archivo no tiene un mapeo explícito y no comienza con `.` en su nombre, `install.sh` aplica la acción `dotify` por defecto y lo instala como `~/.<nombre>` para evitar crear archivos visibles en el HOME.
- `install.sh` además:
	- respeta mapeos XDG (`xdg:` / `xdg_data:` / `xdg_state:` / `xdg_cache:` / `home:`),
	- crea copias sanitizadas para archivos con CRLF en `$TARGET/.dotfiles_sanitized`,
	- realiza backups en `$HOME/.dotfiles_backup/<timestamp>` antes de sobrescribir archivos no enlazados,
	- incluye protecciones de seguridad para evitar eliminación accidental de directorios importantes.

Ejemplos concretos (muy simples):

-- Si en `modules/miapp/` existe un archivo `myapp` (en la raíz del módulo):

	```bash
	./scripts/install.sh modules/miapp
	```

	Resultado: se crea `$HOME/myapp` (sin punto). Aquí `miapp` es el nombre del módulo y `myapp` es el archivo que estaba en el módulo.

-- Si en `modules/miapp/` existe `.config/cargo/config`:

	```bash
	./scripts/install.sh modules/miapp
	```

	Resultado: se crea `~/.config/cargo/config`.

-- Si en `modules/miapp/` existe `cargo/config` (sin punto al inicio):

	```bash
	./scripts/install.sh modules/miapp
	```

	Resultado: se crea `$HOME/cargo/config`.

Diferencia clave con enfoques históricos:

- Algunas aproximaciones tradicionales respetaban exactamente la estructura que hubiera en el módulo y no aplicaban reglas ni transformaciones por defecto. En contraste, `./scripts/install.sh` usa `install-mappings.yml` para aplicar reglas declarativas (ej.: mover `cargo/config` a `~/.config/cargo/config`, o marcar un archivo como `ignore`).

Por eso:
- Si quieres que algo siempre termine en `~/.config/…`, lo puedes colocar en el módulo en esa carpeta (`.config/...`) o declarar un mapeo en `install-mappings.yml` si el repo tiene una estructura distinta.
-- Nota: el instalador `install.sh` usa por defecto la acción `dotify`. Si algo no tiene mapeo y no empieza por un `.` en su nombre, `install.sh` aplicará un prefijo `.` y terminará en `~/.<nombre>`. Los enfoques previos no implicaban esta transformación por defecto.
- Implementación actual: cuando ejecutas `./scripts/install.sh`, los elementos en la raíz de cada módulo que no tienen un mapeo y no empiezan con `.` se instalarán como `~/.<nombre>` automáticamente (dotify). Esto evita que el instalador cree archivos no ocultos en `$HOME` por defecto cuando no hay un mapeo explícito.
-- Para evitar dotify (por ejemplo si prefieres que el archivo termine en `~/miapp`), añade un `.` al nombre en el módulo (`.miapp`) o añade una entrada en `install-mappings.yml` para ese archivo/directorio con la ruta deseada.
-- Si quieres ver qué hará `install.sh` sin aplicarlo, ejecuta en un `TARGET` temporal (simulando `HOME`) y revisa los enlaces creados:

```bash
TMP=$(mktemp -d)
TARGET="$TMP" ./scripts/install.sh modules/miapp
find "$TMP" -maxdepth 3 -ls
```
esto te permitirá revisar los symlinks resultantes sin afectar a tu verdadero HOME.

Agregar un módulo — ejemplo práctico:

1. Crea un nuevo módulo: `modules/miapp/`.
2. Añade la estructura de destino dentro del módulo. Ejemplo: `modules/miapp/.config/miapp/config.yml`.
3. Prueba el módulo con `install.sh` (destino temporal para revisión):

```bash
cd modules
TMP=$HOME/tmp_install_test
mkdir -p "$TMP"
TARGET="$TMP" ../scripts/install.sh miapp
ls -l "$TMP"                 # verifica lo que el instalador aplicaría
```

4. Para aplicar el módulo a tu HOME con el instalador:

```bash
../scripts/install.sh modules/miapp
```

5. Para revertir/desinstalar el módulo (quitar enlaces creados por el instalador):

```bash
# Revertir manualmente: eliminar symlink y restaurar backup si existen
rm -f "$HOME/.miapp"
# o elimina los symlinks devueltos por el instalador de forma manual
```

6. Si necesitas una ruta XDG específica o marcar un archivo para `ignore`, actualiza `install-mappings.yml` con la entrada adecuada (p. ej. `myfile: xdg:myapp/config.yml` o `secret.file: ignore`).

Seguridad — secretos y plantillas (resumen):

- Nunca subas credenciales o claves privadas. Mantén `*.example` como plantillas (p. ej. `.git-credentials.example`).
- El instalador respeta `install-mappings.yml`. El pipeline de CI analiza `modules/` y falla si detecta archivos que parezcan contener secretos; se permiten archivos de plantilla o archivos que solo contienen comentarios.

Contribuciones y pruebas:

- Añade un módulo pequeño con su README y pruebas básicas. El CI ejecuta pruebas para comprobar que `./scripts/install.sh` aplica correctamente los symlinks y que `install-mappings.yml` cubre los archivos raíz de cada módulo.
- Si agregas un módulo que incluye archivos sensibles, proporciona primero un `*.example` y marca la ruta real como `ignore` en `install-mappings.yml`.

Si quieres más ejemplos o que agregue un módulo por defecto al instalador, dime cuáles y lo hago.

--------------------------------------------------------------