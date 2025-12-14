# htop - Monitor de Procesos

Configuración de htop estilo Windows Task Manager para mejor familiaridad.

## Características

- **Orden por CPU** por defecto (como Task Manager)
- **Actualización cada segundo** (delay=10)
- **Vista compacta** con métricas de CPU/Memoria/Swap visibles
- **CPU temperature** y **frequency** monitoreados
- **Colores claros** similares a Windows
- **Mouse habilitado** para interacción
- **Campos similares a Task Manager**: PID, Command, %CPU, %MEM, User, Time, State

## Ubicación

- **XDG**: `~/.config/htop/htoprc`
- **Módulo**: `modules/cli-tools/htop/`

## Instalación

```bash
./scripts/install.sh modules/cli-tools/htop
```

## Uso

Simplemente ejecuta:
```bash
htop
```

## Atajos útiles

- `F6`: Cambiar orden de columnas
- `F5`: Tree view
- `F3`: Buscar proceso
- `F9`: Matar proceso
- `h`: Ayuda
- `q`: Salir
