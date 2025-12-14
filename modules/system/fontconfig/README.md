# Fontconfig - Renderizado de Fuentes

Configuración estilo `fontconfig-ultimate` para renderizado óptimo en pantallas LCD.

## Características

- **Hinting**: slight (mejor balance)
- **Subpixel rendering**: RGB para LCDs
- **Antialiasing**: habilitado
- **Reemplazos de fuentes**: Arial→Liberation Sans, Times→Liberation Serif, Courier→Liberation Mono
- **Bitmap fonts deshabilitadas** para mejor apariencia
- **Artificial bold** para fuentes sin bold nativo

## Ubicación

- **XDG**: `~/.config/fontconfig/fonts.conf`
- **Módulo**: `modules/system/fontconfig/`

## Instalación

```bash
./scripts/install.sh modules/system/fontconfig
```

## Fuentes Recomendadas

Para mejor resultado, instala:
```bash
sudo pacman -S ttf-liberation ttf-dejavu noto-fonts ttf-cascadia-code
```

## Aplicar Cambios

Después de instalar, regenera cache de fuentes:
```bash
fc-cache -fv
```

## Verificar

Ver fuentes disponibles:
```bash
fc-list
```

Ver config aplicada:
```bash
fc-conflist
```
