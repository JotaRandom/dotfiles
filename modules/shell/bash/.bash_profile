# ~/.bash_profile - Bash login shell
# Optimizado para ThinkPad L420 (1366x768)

# Si existe .bashrc, cargarlo
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# PATH adicional
export PATH="$HOME/.local/bin:$PATH"

# Editor
export EDITOR=nvim
export VISUAL=nvim
export PAGER=less

# Locale
export LANG=es_CL.UTF-8
export LC_ALL=es_CL.UTF-8
export LANGUAGE=es_CL:es

# Autostart X en tty1
if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
    exec startx
fi
