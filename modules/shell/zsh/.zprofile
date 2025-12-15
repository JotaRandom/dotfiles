# ~/.zprofile - Zsh login shell
# Optimizado para ThinkPad L420 (1366x768)

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

# XDG Base Directory
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

# Autostart X en tty1
if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
    exec startx
fi
