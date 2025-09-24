# Bash configuration file for consistent, colorful, and informative shell
# Uses Tango color palette to match .Xresources

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Display welcome message: Utilizando bash en hostname
echo -e "\033[38;2;211;215;207mUtilizando bash en $HOSTNAME\033[0m"

# Set a custom prompt: username@hostname:directory $ (Tango colors)
PS1='\[\e[38;2;211;215;207m\]\u@\h\[\e[m\]:\[\e[38;2;78;154;6m\]\w\[\e[m\] \$ '

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
HISTCONTROL=ignoreboth
HISTSIZE=8192
HISTFILESIZE=8192
HISTTIMEFORMAT='%F %T '
shopt -s histappend
shopt -s cmdhist

# Enable programmable completion
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Environment variables
export EDITOR=nano
export VISUAL=nano
export TERM=xterm-256color
export LESSCHARSET=utf-8

# Source additional user-specific configurations
[ -f ~/.bash_aliases ] && . ~/.bash_aliases
[ -f ~/.bash_functions ] && . ~/.bash_functions