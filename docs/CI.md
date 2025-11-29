# CI / GitHub Actions — submódulos SSH

El flujo de CI NO intentará clonar o actualizar submódulos privados automáticamente — esto evita que los runners públicos fallen por falta de acceso SSH.

Comportamiento y detalles:

- `actions/checkout` se ejecuta sin descargar submódulos recursivamente.
- El job `lfs-and-submodule-check` solo valida la presencia de entradas en `.gitmodules` (imprime `path` y `url`) y exporta `SUBMODULES_PRESENT=true` si hay entradas válidas. **NO** se realiza ninguna operación de red ni se intenta clonar submódulos desde CI.

Esto permite que el CI pase correctamente en runners públicos cuando algunos submódulos son privados y solo accesibles para el mantenedor.

Opcionalmente, si un propietario del repositorio desea que CI intente acceder a submódulos privados, puede añadir una clave SSH dedicada como secret (`SUBMODULE_SSH_PRIVATE_KEY`) y el workflow podrá levantar un ssh-agent para esos casos. Esta opción es explícita y debe ser habilitada por alguien con acceso del repo.

Nota de seguridad: no se recomienda añadir claves privadas sin rotación. Si habilitas acceso SSH desde CI, usa una clave dedicada con permisos limitados y rota la clave según políticas de seguridad.