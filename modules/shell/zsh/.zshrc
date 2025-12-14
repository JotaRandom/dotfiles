# .zshrc - Optimizado para ThinkPad L420 (1366x768)

# ===== PROMPT COMPACTO (1 línea para pantalla pequeña) =====
# Usuario@host:directorio$
PROMPT='%F{green}%n@%m%f:%F{blue}%~%f$ '

# ===== HISTORY OPTIMIZADO =====
HISTSIZE=5000
SAVEHIST=5000
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY

# ===== OPCIONES =====
# No beep
unsetopt beep

# Auto cd
setopt auto_cd

# Glob extendido
setopt extended_glob

# ===== COMPLETION =====
autoload -Uz compinit
compinit

# Completion cache (más rápido)
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# Completion con colores
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Completion case-insensitive
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# ===== ALIASES =====
# Navegación
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# ls
alias ls='ls --color=auto -h'
alias ll='ls -la'
alias la='ls -A'
alias l='ls -CF'

# grep
alias grep='grep --color=auto'

# Seguridad
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# ===== FUNCIONES =====
# Crear y entrar directorio
mkcd() {
  mkdir -p "$1" && cd "$1"
}

# ===== FZF INTEGRATION =====
if [ -f ~/.config/fzf/fzf.bash ]; then
  source ~/.config/fzf/fzf.bash
fi

# ===== EXPORTS =====
export EDITOR=nvim
export VISUAL=nvim
export PAGER=less

# ===== KEY BINDINGS =====
# Emacs-style keybindings
bindkey -e

# History search
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search