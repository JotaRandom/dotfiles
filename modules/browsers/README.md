# modules/browsers/

Configuraciones para navegadores web (Chrome, Chromium, Firefox, Brave, etc.)

## Estructura

```
browsers/
├── chrome/
│   └── flags.conf           # Flags para Chrome/Chromium
├── brave/
│   └── brave-flags.conf     # Flags específicos de Brave
└── firefox/
    ├── user.js              # Preferencias de Firefox
    └── userChrome.css       # Personalización de la interfaz de Firefox
```

## Chrome / Chromium

**Archivo:** `modules/browsers/chrome/flags.conf`

Las banderas se aplican en:
- **Linux:** Crear/editar `~/.config/chromium-flags.conf` o `~/.config/chrome-flags.conf`
- **Desktop Entry:** Agregar banderas al archivo `.desktop`
- **Línea de comando:** `chromium --flag-file=~/.config/chromium-flags.conf`

**Flags comunes:**
- `--start-maximized` - Iniciar maximizado
- `--force-dark-mode` - Forzar modo oscuro (si el sitio lo soporta)
- `--enable-features=WebUIDarkMode` - Activa interfaz oscura
- `--enable-parallel-downloading` - Descargas paralelas
- `--gtk-version=4` - Usar GTK 4 (requiere GTK 4 instalado)

## Brave

**Archivo:** `modules/browsers/brave/brave-flags.conf`

Similar a Chrome, Brave hereda muchas flags de Chromium pero añade sus propias opciones.

**Instalación:**
```bash
cp modules/browsers/brave/brave-flags.conf ~/.config/brave/brave-flags.conf
```

## Firefox

**Archivos:**
- `user.js` - Preferencias del navegador (seguridad, rendimiento, privacidad)
- `userChrome.css` - Personalización visual (requiere `toolkit.legacyUserProfileCustomizations.stylesheets = true` en `about:config`)

**Instalación manual:**
1. Abrir Firefox y navegar a `about:profiles`
2. Localizar el perfil activo (usualmente `~/.mozilla/firefox/PROFILE_ID/`)
3. Copiar archivos:
   ```bash
   cp modules/browsers/firefox/user.js ~/.mozilla/firefox/PROFILE_ID/
   mkdir -p ~/.mozilla/firefox/PROFILE_ID/chrome
   cp modules/browsers/firefox/userChrome.css ~/.mozilla/firefox/PROFILE_ID/chrome/
   ```
4. En `about:config`, cambiar `toolkit.legacyUserProfileCustomizations.stylesheets` a `true` (para CSS personalizado)
5. Reiniciar Firefox

## Notas de Compatibilidad

- **Chrome flags:** Compatible con Chrome, Chromium, Edge, Brave (basados en Chromium)
- **Firefox:** Requiere reinicio del navegador para algunos cambios
- **GTK version:** Verificar qué versión de GTK está instalada en tu sistema (`gtk-launch`)

## Futuras Adiciones

Posibles navegadores a configurar:
- `modules/browsers/firefox/` ✓ (base creada)
- `modules/browsers/edge/` 
- `modules/browsers/safari/` (macOS)
- `modules/browsers/librewolf/` (Firefox hardened)
- `modules/browsers/ungoogled-chromium/`
