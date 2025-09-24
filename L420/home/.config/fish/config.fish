# Fish configuration file for consistent, colorful, and informative shell
# Uses Tango color palette to match .Xresources
# Save to ~/.config/fish/config.fish

# Display welcome message: Utilizando fish en hostname
printf "\033[38;2;211;215;207mUtilizando fish en %s\033[0m\n" $hostname

# Set prompt: username@hostname:directory $ (Tango colors)
function fish_prompt
    set_color -o D3D7CF
    echo -n "$USER@$hostname"
    set_color normal
    echo -n ':'
    set_color -o 4E9A06
    echo -n (prompt_pwd)
    set_color normal
    echo -n ' $ '
end

# Common aliases for productivity
alias ll='ls -l --human-readable'
alias la='ls -la --human-readable'
alias nano='nano --rcfile ~/.nanorc'
alias vi='nano'
alias less='less -R'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# History settings: large, persistent
set fish_history_size 8192
set fish_history_path ~/.local/share/fish/fish_history

# Enable color support for ls and grep
if type -q dircolors
    eval (dircolors -c)
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
end

# Enable completion (case-insensitive by default in Fish)
set -g fish_complete_path $fish_complete_path

# Environment variables
set -gx EDITOR nano
set -gx VISUAL nano
set -gx TERM xterm-256color
set -gx LESSCHARSET utf-8

# Source additional user-specific configurations
if test -f ~/.fish_aliases
    source ~/.fish_aliases
end