Contribuyendo al repositorio

Reglas básicas:
- Si añades dotfiles nuevos que sean globales (bash, zsh, tmux), colócalos en `modules/<role>` y asegúrate que son `stow`-friendly.
- No añadas binarios directamente en `modules/` — usa `assets/` para archivos multimedia o instala scripts que descarguen binarios.
- Archivos exclusivos de hardware o que no deban usarse en otras máquinas vayan en `machines/<name>/` con un `README` que explique su propósito.
- Si agregas imágenes, adjunta `ATTRIBUTIONS.md` o un archivo `.license` por imagen si aplica.

Workflow recomendado:
1. Crear una rama: `git checkout -b feature/<nueva-config>`.
2. Añadir cambios pequeños y testear `stow` si aplicable.
3. Abrir un Pull Request con descripción detallada y capturas o notas de prueba.
