## Moved config for fish to the expected XDG path
# This file was previously at the module root (which created $HOME/config.fish).
# Stow will link this to $HOME/.config/fish/config.fish

set -g -x PATH $HOME/bin $PATH
# prompt and basic behaviour
set -g theme_nerd_fonts yes
