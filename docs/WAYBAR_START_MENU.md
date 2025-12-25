# Waybar Start Menu Configuration

El botón "Start" en waybar está configurado para ejecutar `dmenu_run` cuando se hace clic. Hay varias opciones para configurar el menú:

## Opción 1: dmenu (Minimalista, estilo Win95)

**Instalar:**
```bash
sudo pacman -S dmenu
```

**Ya configurado en waybar** - El botón Start ejecuta:
```bash
dmenu_run -fn 'Sans-9' -nb '#C0C0C0' -nf '#000000' -sb '#000080' -sf '#FFFFFF'
```

Esto muestra un menú simple en la parte superior con el estilo Win95 (gris con selección azul).

## Opción 2: rofi (Más moderno, personalizable)

**Instalar:**
```bash
sudo pacman -S rofi
```

**Configurar en waybar** - Editar `~/.config/waybar/config.jsonc`:
```jsonc
"custom/start": {
  "format": " Start",
  "on-click": "rofi -show drun -theme ~/.config/rofi/win95.rasi",
  "tooltip": false
}
```

**Crear tema Win95 para rofi** (`~/.config/rofi/win95.rasi`):
```css
* {
    background-color: #C0C0C0;
    border-color: #FFFFFF #808080 #808080 #FFFFFF;
    text-color: #000000;
    selected-normal-background: #000080;
    selected-normal-foreground: #FFFFFF;
}

window {
    border: 2px;
    padding: 5px;
}

listview {
    border: 2px solid;
    padding: 2px;
}
```

## Opción 3: wofi (Wayland nativo)

**Instalar:**
```bash
sudo pacman -S wofi
```

**Configurar en waybar**:
```jsonc
"custom/start": {
  "format": " Start",
  "on-click": "wofi --show drun --style ~/.config/wofi/style.css",
  "tooltip": false
}
```

**Crear estilo Win95** (`~/.config/wofi/style.css`):
```css
window {
    background-color: #C0C0C0;
    border: 2px solid #FFFFFF;
}

#input {
    background-color: #FFFFFF;
    border: 2px inset;
    color: #000000;
}

#entry:selected {
    background-color: #000080;
    color: #FFFFFF;
}
```

## Opción 4: nwg-drawer (Estilo grid, similar a Windows)

**Instalar:**
```bash
sudo pacman -S nwg-drawer
```

**Configurar en waybar**:
```jsonc
"custom/start": {
  "format": " Start",
  "on-click": "nwg-drawer",
  "tooltip": false
}
```

## Recomendación

Para el estilo Windows 95/98 más auténtico:
1. **dmenu** - Más simple y ligero, ya configurado
2. **rofi** - Más personalizable, mejor para un menú tipo "Start" completo

## Probar el menú

Después de instalar dmenu (o la opción que prefieras):
```bash
# Reiniciar waybar
killall waybar
waybar &

# O simplemente hacer clic en el botón Start
```

El menú debería aparecer mostrando todas las aplicaciones instaladas.
