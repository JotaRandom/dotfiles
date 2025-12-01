# XMMS (xmms2) module

Este módulo contiene una configuración mínima de ejemplo para XMMS2.

Instalación y uso:

1. Con el instalador, `./scripts/install.sh modules/apps/xmms` colocará el archivo de configuración en `~/.xmms2rc` o `~/.xmms2/config` según la estructura del usuario.
2. Revisa y ajusta `modules/apps/xmms/.xmms2rc` a tu entorno (música en `~/Music`, socket de daemon, etc.).
3. Si usas el demonio de XMMS2, asegúrate de que la ruta del socket sea accesible y `daemon.enabled` esté a `true`.

Notes:
- Este archivo es un ejemplo minimalista. XMMS2 tiene más opciones de configuración, revisa `man xmms2` o `https://xmms2.org/` para opciones avanzadas.
