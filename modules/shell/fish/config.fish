# config.fish - Fish Shell optimizado para ThinkPad L420 (1366x768)

# ===== PROMPT COMPACTO (1 línea para pantalla pequeña) =====
# Prompt simple: usuario@host:dir$
function fish_prompt
    set_color green
    echo -n (whoami)
    set_color normal
    echo -n '@'
    set_color green
    echo -n (prompt_hostname)
    set_color normal
    echo -n ':'
    set_color blue
    echo -n (prompt_pwd)
    set_color normal
    echo -n '$ '
end

# ===== HISTORY OPTIMIZADO =====
# Reducido para ThinkPad
set -g fish_history_max 5000

# ===== ALIASES =====
# Navegación
alias .. 'cd ..'
alias ... 'cd ../..'
alias .... 'cd ../../..'

# ls con colores
alias ls 'ls --color=auto -h'
alias ll 'ls -la'
alias la 'ls -A'
alias l 'ls -CF'

# grep con colores
alias grep 'grep --color=auto'

# Seguridad
alias rm 'rm -i'
alias cp 'cp -i'
alias mv 'mv -i'

# ===== VARIABLES =====
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx PAGER less

# ===== FZF INTEGRATION =====
# Si fzf está instalado
if type -q fzf
    set -gx FZF_DEFAULT_OPTS '--height 40% --layout=reverse --border'
end

# ===== FUNCIONES ÚTILES =====
# Crear directorio y entrar
function mkcd
    mkdir -p $argv[1]
    and cd $argv[1]
end

# ===== PERFORMANCE =====
# Deshabilitar greeting
set fish_greeting
