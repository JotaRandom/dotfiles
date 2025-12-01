## Configuración de fish movida a la ruta XDG esperada
# Este archivo estaba previamente en la raíz del módulo (lo que creaba $HOME/config.fish).
# El instalador lo enlazará a $HOME/.config/fish/config.fish

set -g -x PATH $HOME/bin $PATH
# prompt y comportamiento básico
set -g theme_nerd_fonts yes
