Contribuyendo al repositorio

Reglas básicas:
- Si añades dotfiles nuevos que sean globales (bash, zsh, tmux), colócalos en `modules/<role>` y asegúrate que son `stow`-friendly.
- No añadas binarios directamente en `modules/` — usa `assets/` para archivos multimedia o instala scripts que descarguen binarios.
- Archivos exclusivos de hardware o que no deban usarse en otras máquinas vayan en `machines/<name>/` con un `README` que explique su propósito.
- Si agregas imágenes, adjunta `ATTRIBUTIONS.md` o un archivo `.license` por imagen si aplica.

Submodules (PKGBUILD / AUR packages)
- Algunos paquetes AUR se agregan como submodules dentro de `distros/PKGBUILD/` (por ejemplo: `xfce-theme-greybird-git`, `micropolis-java`).
- Para actualizar un submodule a su última versión upstream:
	```bash
	cd distros/PKGBUILD/<package>
	git pull origin master  # o la rama correspondiente
	cd -
	git add distros/PKGBUILD/<package>
	git commit -m "chore: update submodule <package> to latest upstream"
	git push origin <branch>
	```

- Alternativamente, desde la raíz puedes ejecutar:
	```bash
	git submodule update --remote distros/PKGBUILD/<package>
	git add distros/PKGBUILD/<package>
	git commit -m "chore: update submodule <package>"
	```

- Al clonar el repo, usa `git clone --recurse-submodules` o después ejecutar:
	```bash
	git submodule update --init --recursive
	```

Workflow recomendado:
1. Crear una rama: `git checkout -b feature/<nueva-config>`.
2. Añadir cambios pequeños y testear `stow` si aplicable.
3. Abrir un Pull Request con descripción detallada y capturas o notas de prueba.
