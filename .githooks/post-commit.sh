#!/bin/sh
command -v git-lfs >/dev/null 2>&1 || { printf >&2 "\n%s\n\n" "Este repositorio está configurado para Git LFS pero 'git-lfs' no se encontró en tu PATH. Si ya no deseas usar Git LFS, elimina este hook borrando el archivo 'post-commit' en el directorio de hooks (configurado por 'core.hookspath'; normalmente '.git/hooks')."; exit 2; }
git lfs post-commit "$@"
