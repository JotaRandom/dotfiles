#!/usr/bin/env bash
# ~/.bashrc
# Bash — configuración principal para sesiones interactivas
# Este archivo establece alias, colores, prompt y opciones de historial.
# Conservamos un estilo "retro" (estética DOS) y soporte UTF-8/latino.

# Si la shell no se está ejecutando de forma interactiva, no hacer nada
[[ $- != *i* ]] && return


# --------------------------------------------------------------
# 1. COLORES PERMANENTES (ls, grep, etc.)
# --------------------------------------------------------------
# Forzar --color=always en alias comunes
alias ls='ls --color=always --literal'
alias dir='ls --color=always --literal -l'
alias ll='ls --color=always --literal -la'
alias grep='grep --color=always'
alias egrep='egrep --color=always'
alias fgrep='fgrep --color=always'
alias diff='diff --color=always'

# Exportar variables para programas que las lean (colores por defecto)
# - GREP_COLORS: define el color de resaltado de las coincidencias en grep
# - LS_COLORS: controla colores en 'ls'; aquí se configura un tema simple
export GREP_COLORS='mt=01;32'  # Verde brillante para coincidencias
export LS_COLORS='di=01;34:ln=01;36:ex=01;32:*.*=00'  # Estilo DOS-like

# --------------------------------------------------------------
# 2. PROMPT ESTILO DOS (C:\> pero con verde)
# --------------------------------------------------------------
# Prompt: simple y retro (C:\ruta>) — explicado:
# - GREEN y RESET son secuencias ANSI para color en la shell interactiva
# - La forma del prompt imita 'C:\ruta>' para dar una estética retro
GREEN='\[\e[01;32m\]'   # Verde brillante
RESET='\[\e[0m\]'       # Restablecer color

# Construcción del prompt
# Nota: ${PWD#/} elimina el primer '/' de PWD para obtener la ruta sin slash inicial
# Para estética "C:\ruta>", usamos la ruta completa como está
PS1="${GREEN}C:\\${PWD}${RESET}> "

# Si estás en tmux, añade [tmux]
# Si estamos dentro de una sesión tmux, indicarlo en el prompt (ayuda visual)
if [ -n "$TMUX" ]; then
    PS1="[tmux] $PS1"
fi

# --------------------------------------------------------------
# 3. HISTORIAL Y COMPLETADO
# --------------------------------------------------------------
## HISTORIAL — registro de comandos
# - HISTSIZE/HISTFILESIZE: tamaño en memoria y en disco
# - histappend: evita sobrescribir historial en sesiones múltiples
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s histappend
shopt -s cdspell    # corrige pequeños errores al escribir nombres de directorios
shopt -s autocd 2>/dev/null  # permite cambiar de directorio solo con 'nombre'

# --------------------------------------------------------------
# 4. SOPORTE LATINO (ñ, acentos y UTF-8)
# Establecemos locales para que las aplicaciones textuales manejen caracteres
# acentuados, símbolos en español y codificación UTF-8 por defecto.
# Nota: en sistemas multi-usuario puede preferirse /etc/locale.conf
export LANG=es_CL.UTF-8
export LC_ALL=es_CL.UTF-8

# --------------------------------------------------------------
# 5. ALIAS ÚTILES (estilo DOS y comandos seguros)
# --------------------------------------------------------------
alias cls='clear'
alias copy='cp'
alias move='mv'
alias del='rm'
alias rd='rmdir'
alias md='mkdir'
alias type='cat'
alias ver='uname -a; echo "Bash $(bash --version | head -1)"'
alias exit='exit'

# --------------------------------------------------------------
# 6. CARGAR .inputrc (teclas de edición)
# --------------------------------------------------------------
# Cargar configuración de readline si existe (~/.inputrc)
if [ -f ~/.inputrc ]; then
    bind -f ~/.inputrc
fi
