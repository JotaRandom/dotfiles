# ~/.bashrc
# Bash retro: prompt DOS + colores siempre ON + soporte latino

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

# Exportar variables para programas que las lean
export GREP_COLORS='mt=01;32'  # Verde brillante para coincidencias
export LS_COLORS='di=01;34:ln=01;36:ex=01;32:*.*=00'  # Estilo DOS-like

# --------------------------------------------------------------
# 2. PROMPT ESTILO DOS (C:\> pero con verde)
# --------------------------------------------------------------
# Verde fosforescente (como xterm)
GREEN='\[\e[01;32m\]'   # Brillante
RESET='\[\e[0m\]'

# Prompt simple: C:\ruta>
PS1="${GREEN}C:${PWD#>}${RESET}> "

# Si estás en tmux, añade [tmux]
if [ -n "$TMUX" ]; then
    PS1="[tmux] $PS1"
fi

# --------------------------------------------------------------
# 3. HISTORIAL Y COMPLETADO
# --------------------------------------------------------------
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s histappend
shopt -s cdspell
shopt -s autocd 2>/dev/null

# --------------------------------------------------------------
# 4. SOPORTE LATINO (ñ, acentos)
# --------------------------------------------------------------
export LANG=es_CL.UTF-8
export LC_ALL=es_CL.UTF-8

# --------------------------------------------------------------
# 5. ALIAS ÚTILES ESTILO DOS
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
if [ -f ~/.inputrc ]; then
    bind -f ~/.inputrc
fi
