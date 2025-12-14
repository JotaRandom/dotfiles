# fzf configuration - Fuzzy Finder
# ~/.config/fzf/fzf.bash (también funciona en zsh)

# ===== OPCIONES GENERALES =====
export FZF_DEFAULT_OPTS="
  --height 60%
  --layout=reverse
  --border
  --inline-info
  --preview-window=right:60%:wrap
  --bind ctrl-u:preview-page-up,ctrl-d:preview-page-down
  --bind ctrl-/:toggle-preview
  --bind alt-a:select-all,alt-d:deselect-all
  --color=dark
  --color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f
  --color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7
"

# ===== COMANDO POR DEFECTO =====
# Usar fd si está disponible (más rápido y respeta .gitignore)
if command -v fd &> /dev/null; then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
else
  export FZF_DEFAULT_COMMAND='find . -type f'
fi

# ===== PREVIEW COMMANDS =====
# Preview de archivos con bat (si está disponible)
if command -v bat &> /dev/null; then
  export FZF_CTRL_T_OPTS="
    --preview 'bat --color=always --style=numbers --line-range=:500 {}'
    --preview-window 'right:60%:wrap'
  "
else
  export FZF_CTRL_T_OPTS="
    --preview 'cat {}'
    --preview-window 'right:60%:wrap'
  "
fi

# Preview de directorios con tree
if command -v tree &> /dev/null; then
  export FZF_ALT_C_OPTS="
    --preview 'tree -C {} | head -200'
  "
else
  export FZF_ALT_C_OPTS="
    --preview 'ls -la {}'
  "
fi

# ===== KEY BINDINGS =====
# Ctrl-T: buscar archivos
# Ctrl-R: history
# Alt-C: cambiar directorio

# ===== FUNCIONES ÚTILES =====

# fh - buscar en history con preview
fh() {
  eval $(history | fzf --tac --no-sort | sed 's/^ *[0-9]* *//')
}

# fkill - matar procesos interactivamente
fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
  if [ "x$pid" != "x" ]; then
    echo "$pid" | xargs kill -${1:-9}
  fi
}

# fcd - cd a directorio usando fzf
fcd() {
  local dir
  dir=$(fd --type d --hidden --follow --exclude .git | fzf --preview 'tree -C {} | head -200')
  if [ -n "$dir" ]; then
    cd "$dir"
  fi
}

# fedit - abrir archivo en editor con fzf
fedit() {
  local file
  file=$(fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}')
  if [ -n "$file" ]; then
    ${EDITOR:-vim} "$file"
  fi
}

# fgit - checkout git branch con preview
fgit() {
  local branches branch
  branches=$(git branch -a) &&
  branch=$(echo "$branches" | fzf --preview 'git log --oneline --color=always {}') &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# ===== INTEGRACIÓN CON SHELLS =====
# Auto-completado mejorado para comandos comunes
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}
