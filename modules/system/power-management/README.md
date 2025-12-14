# TLP - Power Management para ThinkPad L420

Configuración optimizada de TLP 1.9.0 para ThinkPad L420 (Sandy Bridge).

## Características

### CPU
- **Governor**: `ondemand` (AC) / `powersave` (BAT)
- **Turbo Boost**: ON (AC) / OFF (BAT) para ahorrar batería
- **Freq range**: 800MHz - 2.4GHz (AC), 800MHz - 1.6GHz (BAT)

### Disco
- **I/O Scheduler**: `mq-deadline` (balance SSD/HDD)
- **APM**: 254 (AC) / 128 (BAT)
- **Spindown**: deshabilitado

### ThinkPad Específico
- **Battery thresholds**: Start=75%, Stop=80% (alargar vida de batería)
- Intel HD Graphics (Sandy Bridge) optimizado

### Otros
- WiFi power save: OFF (AC) / ON (BAT)
- PCIe ASPM: performance (AC) / powersave (BAT)
- USB autosuspend habilitado

## Ubicación

- **Sistema**: `/etc/tlp.conf` (requiere root)
- **Módulo**: `modules/system/power-management/`

## Instalación

⚠️ **Requiere permisos de root** - NO usar install.sh para esto.

### Instalar TLP

```bash
sudo pacman -S tlp tlp-rdw
```

### Copiar config manualmente

```bash
sudo cp modules/system/power-management/tlp.conf /etc/tlp.conf
```

### Habilitar y arrancar

```bash
sudo systemctl enable tlp.service
sudo systemctl start tlp.service
```

### Deshabilitar servicios conflictivos

```bash
sudo systemctl mask systemd-rfkill.service systemd-rfkill.socket
```

## Verificar

Estado de TLP:
```bash
sudo tlp-stat -s
```

Batería:
```bash
sudo tlp-stat -b
```

Temperatura y frecuencias CPU:
```bash
sudo tlp-stat -t
sudo tlp-stat -p
```

## Thresholds de Batería

Ver thresholds actuales:
```bash
sudo tlp-stat -b | grep "charge.*threshold"
```

Los thresholds (75/80%) ayudan a alargar la vida de la batería evitando carga al 100% constantemente.

## Notas para L420

- CPU: Intel Sandy Bridge (2ª Gen)
- GPU: Intel HD Graphics
- Batería: Soporta thresholds
- Sin dGPU, config simplificada
