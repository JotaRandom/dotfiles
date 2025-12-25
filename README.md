# 🗄️ dotfiles — Windows 95/98 Retro Experience

Este repositorio contiene una colección de configuraciones (dotfiles) algunas diseñadas para recrear la icónica estética **Windows 95/98 (Retro/Chicago95)** en entornos modernos de Linux y Windows. Todo el sistema está gestionado por un potente instalador multiplataforma escrito en **Python**.

---

## 🚀 Inicio Rápido

### 1) Preparación
Clona el repositorio e inicializa los componentes pesados (imágenes y fuentes):

```bash
git clone --recurse-submodules https://github.com/JotaRandom/dotfiles.git ~/dotfiles
cd ~/dotfiles
git lfs install && git lfs pull
```

### 2) Instalación (Gestor Python)
El instalador en Python es el motor principal que gestiona symlinks, backups automáticos y sanitización de archivos.

> [!TIP]
> Si tu intérprete de Python por defecto ya es la versión 3, puedes usar `python` en lugar de `python3` en los siguientes comandos.

**Instalación completa (Recomendado):**
```bash
python3 scripts/install.py install
```

**Instalación de módulos específicos:**
```bash
python3 scripts/install.py install modules/desktop/gtk modules/shell/zsh
```

**Uso en Windows (PowerShell):**
```powershell
./scripts/install.ps1
```

---

## 🛠️ Comandos del Instalador

| Comando | Descripción |
| :--- | :--- |
| `install` | Crea symlinks según `install-mappings.yml`. |
| `backup-list` | Lista los backups disponibles en `~/.dotfiles_backup/`. |
| `backup-restore` | Restaura archivos (usa `--latest` o `--timestamp <ID>`). |
| `backup-clean <N>` | Mantiene solo los `N` backups más recientes. |
| `check-fonts` | Verifica e instala las fuentes retro requeridas. |
| `check-gitlfs` | Asegura que los assets binarios se descargaron correctamente. |
| `update-submodules` | Actualiza submódulos de paquetes (PKGBUILD) o del repo (`--repo`). |
| `inspect-mappings` | Genera un reporte detallado del estado de los mapeos. |
| `setup-githooks` | Configura hooks de Git y normaliza permisos de ejecución. |

### Opciones avanzadas de `install`
Personaliza tu instalación con estas flags:
- `--dry-run`: Previsualiza los cambios sin afectar al sistema.
- `--fix-attributes`: Configura automáticamente bits de ejecución en scripts.
- `--fix-eol`: Convierte finales de línea CRLF a LF (útil si editas en Windows).
- `--no-backup`: Salta la creación de copias de seguridad (usar con precaución).

---

## 🎨 Enfoque Estético: Windows 95/98 (En curso)
Este repo incluye módulos específicos diseñados para recrear un sistema de diseño retro coherente:

- **Chicago95/Classic 98**: Temado profundo para **GTK 2, 3 y 4**.
- **Paleta de Colores**: Basada en el esquema original: Gris Cálido (`#D4D0C8`) y Azul Marino (`#0A246A`).
- **Efectos 3D**: Bordes biselados, widgets y scrollbars clásicos mediante CSS modular.
- **Componentes de Escritorio**:
  - **Wayland**: [Labwc](https://github.com/labwc/labwc) (WM), [Waybar](https://github.com/Alexays/Waybar) (Taskbar), [Wofi](https://hg.sr.ht/~scoopta/wofi) (Start Menu).
  - **X11**: Openbox, XFWM4, Metacity.

---

## 📂 Estructura y Mapeo

El "cerebro" del sistema es `install-mappings.yml`. El instalador lo utiliza para aplicar reglas declarativas:

- `xdg:` → Enlaza a `~/.config/...`
- `home:` → Enlaza directamente a la raíz del `$HOME`.
- `ignore` → Ignora archivos de mantenimiento o temporales.
- **Acción "Dotify" (Por defecto)**: Si un archivo no tiene regla explícita, el instalador le añade un punto `.` y lo enlaza en el HOME (ej: `bashrc` → `~/.bashrc`) para mantener el orden.

---

## 🤝 Contribuciones y Seguridad

- **Backups**: Ante cualquier conflicto, el instalador protege tus archivos originales en `~/.dotfiles_backup/` con un timestamp.
- **Sanitización**: Normalización automática de archivos para asegurar que funcionen en Linux incluso si fueron descargados en Windows.
- **Seguridad**: Evita subir secretos. El CI escanea proactivamente en busca de credenciales antes de aceptar cambios.

---

*“Everything is a link, until it's a backup.”*