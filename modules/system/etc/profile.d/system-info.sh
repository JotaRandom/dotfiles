#!/bin/sh
# Script de información del sistema al abrir shell interactivo
# Muestra resumen básico: hostname, kernel, load, memoria

# Solo ejecutar en shells interactivos de login (no en scripts)
if [ -t 0 ] && [ -z "$SYSTEM_INFO_SHOWN" ]; then
    export SYSTEM_INFO_SHOWN=1
    
    # Detectar colores disponibles
    if [ -t 1 ]; then
        _bold=$(printf '\033[1m')
        _reset=$(printf '\033[0m')
    fi
    
    echo "${_bold}=== System Information ===${_reset}"
    
    # Hostname y usuario
    if command -v uname >/dev/null 2>&1; then
        echo "Host: $(hostname) ($(uname -s))"
    else
        echo "Host: $(hostname)"
    fi
    
    # Kernel
    if command -v uname >/dev/null 2>&1; then
        echo "Kernel: $(uname -r)"
    fi
    
    # Uptime
    if command -v uptime >/dev/null 2>&1; then
        uptime_output=$(uptime | sed 's/.*up //;s/,.*//')
        echo "Uptime: $uptime_output"
    fi
    
    # Load average (si disponible)
    if [ -f /proc/loadavg ]; then
        load=$(awk '{print $1, $2, $3}' /proc/loadavg)
        echo "Load: $load"
    fi
    
    # Memoria
    if [ -f /proc/meminfo ]; then
        mem_total=$(awk '/MemTotal/ {print int($2/1024)}' /proc/meminfo)
        mem_available=$(awk '/MemAvailable/ {print int($2/1024)}' /proc/meminfo)
        mem_used=$((mem_total - mem_available))
        echo "Memory: ${mem_used}M / ${mem_total}M"
    fi
    
    echo
fi
