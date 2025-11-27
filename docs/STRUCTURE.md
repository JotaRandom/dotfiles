Estructura del repositorio (propuesta híbrida)

Top-level:
- modules/: módulos stowables y compartidos (dotfiles por función)
  - shell/: bash, zsh, fish, etc.
  - desktop/: xfce, x11, etc.
  - system/: etc/ config (udev, modprobe.d, X11)
  - pkgbuilder/: scripts y PKGBUILD relacionados
    - PKGBUILD/: colecciones de PKGBUILDs; algunos paquetes se mantienen como submodules (distros/PKGBUILD/*) para facilitar su actualización desde AUR.
  - scripts/: utilidades para instalar/desplegar
- machines/: archivos específicos por hardware (archivos DSDT, perfiles, dumps)
  - L420/: máquina actual (hardware y archivos históricos específicos)
  - Toshiba/: máquina antigua (archivo histórico)
- assets/: imágenes y recursos multimedia
  - poni/: recursos de ponysay (migrados desde Toshiba/poni)
- docs/: documentación y guías (README, STRUCTURE, CONTRIBUTING)
- .gitattributes, .editorconfig, .gitignore

Guía rápida:
- Si quieres desplegar dotfiles en tu máquina, usa `modules/` con `stow`.
- Mantén en `machines/` solo los archivos específicos de hardware que no son modulares.
- Usa `assets/` para binarios y recursos (imágenes, íconos) — estos están trackeados con Git LFS cuando corresponda.

Notas:
- Esta estructura ofrece un balance entre modularidad (módulos reusables) y preservación del historial por máquina.
- Recomendamos revisar los módulos y mantenerlos minimalistas y stow-friendly.
