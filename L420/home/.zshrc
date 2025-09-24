# Zsh configuration file for consistent, colorful, and informative shell
# Uses Tango color palette to match .Xresources

# Display welcome message: Utilizando zsh en hostname
printf "\033[38;2;211;215;207mUtilizando zsh en %s\033[0m\n" $HOST

# Set prompt: username@hostname:directory $ (Tango colors)
autoload -U colors && colors
PS1='%F{white}%n@%m%f:%F{142}%~%f \$ '

# Enable color support for ls and grep
if [ -x /usr/bin/dircolors ]; then
    eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
fi

# Common aliases for productivity
alias ll='ls -l --human-readable'
alias la='ls -la --human-readable'
alias nano='nano --rcfile ~/.nanorc'
alias vi='nano'
alias less='less -R'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# History settings: large, timestamped, append mode
HISTFILE=~/.zsh_history
HISTSIZE=8192
SAVEHIST=8192
setopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_BY_COPY
setopt EXTENDED_HISTORY

# Enable completion
autoload -Uz compinit
compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Environment variables
export EDITOR=nano
export VISUAL=nano
export TERM=xterm-256color
export LESSCHARSET=utf-8

# Source additional user-specific configurations
[ -f ~/.zsh_aliases ] && . ~/.zsh_aliases
[ -f ~/.zsh_functions ] && . ~/.zsh_functions