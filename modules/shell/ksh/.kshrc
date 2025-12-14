# ~/.kshrc - Korn Shell optimizado para ThinkPad L420 (1366x768)

# ===== PROMPT COMPACTO (1 línea) =====
PS1='$(whoami)@$(hostname):$PWD$ '

# ===== HISTORY =====
HISTSIZE=5000
HISTFILE=~/.ksh_history

# ===== ALIASES =====
alias ..='cd ..'
alias ...='cd ../..'
alias ls='ls --color=auto -h'
alias ll='ls -la'
alias la='ls -A'
alias grep='grep --color=auto'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# ===== EDITOR =====
export EDITOR=nvim
export VISUAL=nvim
export PAGER=less

# ===== FUNCIONES =====
mkcd() {
    mkdir -p "$1" && cd "$1"
}
