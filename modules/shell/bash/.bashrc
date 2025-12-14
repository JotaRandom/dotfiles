# .bashrc - Optimizado para ThinkPad L420 (1366x768)

# Si no es interactivo, no hacer nada
[[ $- != *i* ]] && return

# ===== PROMPT COMPACTO (1 línea para pantalla pequeña) =====
# Usuario@host:directorio$
PS1='\[\e[32m\]\u@\h\[\e[0m\]:\[\e[34m\]\w\[\e[0m\]\$ '

# ===== HISTORY OPTIMIZADO =====
# Reducido para ThinkPad
HISTSIZE=5000
HISTFILESIZE=5000
HISTCONTROL=ignoreboth:erasedups
shopt -s histappend

# ===== OPCIONES DE SHELL =====
# Checkwinsize después de cada comando
shopt -s checkwinsize

# Globbing mejorado
shopt -s globstar 2>/dev/null

# ===== ALIASES ÚTILES =====
# Navegación rápida
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# ls con colores
alias ls='ls --color=auto -h'
alias ll='ls -la'
alias la='ls -A'
alias l='ls -CF'

# grep con colores
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Seguridad
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Disk usage
alias df='df -h'
alias du='du -h'

# ===== FUNCIONES ÚTILES =====
# Crear directorio y entrar
mkcd() {
  mkdir -p "$1" && cd "$1"
}

# Extraer archivos comprimidos
extract() {
  if [ -f "$1" ]; then
    case "$1" in
      *.tar.bz2)   tar xjf "$1"    ;;
      *.tar.gz)    tar xzf "$1"    ;;
      *.bz2)       bunzip2 "$1"    ;;
      *.rar)       unrar x "$1"    ;;
      *.gz)        gunzip "$1"     ;;
      *.tar)       tar xf "$1"     ;;
      *.tbz2)      tar xjf "$1"    ;;
      *.tgz)       tar xzf "$1"    ;;
      *.zip)       unzip "$1"      ;;
      *.Z)         uncompress "$1" ;;
      *.7z)        7z x "$1"       ;;
      *)           echo "'$1' no se puede extraer" ;;
    esac
  else
    echo "'$1' no es un archivo válido"
  fi
}

# ===== FZF INTEGRATION =====
# Si fzf está instalado, cargar configuración
if [ -f ~/.config/fzf/fzf.bash ]; then
  source ~/.config/fzf/fzf.bash
fi

# ===== COMPLETIONS =====
# Bash completion
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# ===== EXPORTS =====
export EDITOR=nvim
export VISUAL=nvim
export PAGER=less

# ===== MENOS VERBOSE =====
# Deshabilitar beep
bind 'set bell-style none' 2>/dev/null
