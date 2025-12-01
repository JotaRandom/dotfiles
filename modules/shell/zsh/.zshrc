# Configuración de Zsh — opciones principales y alias
# Este archivo configura prompt, color, historial y completado.
# Usa colores type "Tango" y respeta variables de entorno globales (*.Xresources).

## Mensaje de bienvenida (útil en sesiones interactivas)
printf "\033[38;2;211;215;207mUtilizando zsh en %s\033[0m\n" $HOST

# Prompt: username@host:pwd $
# - %n: usuario, %m: hostname corto, %~: directorio relativo
autoload -U colors && colors
PS1='%F{white}%n@%m%f:%F{142}%~%f \$ '

## Color en herramientas estándar
if [ -x /usr/bin/dircolors ]; then
    eval "$(dircolors -b)"    # carga esquema de colores para terminal
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
fi

# Alias comunes para mejorar la productividad
alias ll='ls -l --human-readable'
alias la='ls -la --human-readable'
alias nano='nano --rcfile ~/.nanorc'
alias vi='nano'
alias less='less -R'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

## Historial: tamaño y opciones para mantener historial sano y completo
HISTFILE=~/.zsh_history
HISTSIZE=8192
SAVEHIST=8192
setopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_BY_COPY
setopt EXTENDED_HISTORY

## Autocompletado y comportamiento de coincidencias (case-insensitive)
autoload -Uz compinit
compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Environment variables
export EDITOR=nano
export VISUAL=nano
export TERM=xterm-256color
export LESSCHARSET=utf-8

# Cargar alias y funciones definidos por usuario si existen
[ -f ~/.zsh_aliases ] && . ~/.zsh_aliases
[ -f ~/.zsh_functions ] && . ~/.zsh_functions