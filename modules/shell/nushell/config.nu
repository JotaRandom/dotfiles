# Nushell Config - Optimizado para ThinkPad L420 (1366x768)
# ~/.config/nushell/config.nu

# ===== PROMPT COMPACTO =====
# Configurar prompt de 1 línea
let-env PROMPT_COMMAND = {
    let user = (whoami)
    let host = (hostname)
    let path = ($env.PWD | path basename)
    $"(ansi green)($user)@($host)(ansi reset):(ansi blue)($path)(ansi reset)$ "
}

# ===== HISTORY =====
# Reducido para ThinkPad
let-env config = {
    history: {
        max_size: 5000
        sync_on_enter: true
        file_format: "plaintext"
    }
    
    # ===== PERFORMANCE =====
    # Timeouts optimizados
    shell_integration: true
    use_ansi_coloring: true
    footer_mode: 25
    
    # ===== COMPLETIONS =====
    completions: {
        case_sensitive: false
        quick: true
        partial: true
        algorithm: "prefix"
    }
    
    # ===== KEYBINDINGS =====
    keybindings: [
        {
            name: completion_menu
            modifier: none
            keycode: tab
            mode: [emacs, vi_normal, vi_insert]
            event: {
                until: [
                    { send: menu name: completion_menu }
                    { send: menunext }
                ]
            }
        }
    ]
}

# ===== ALIASES =====
alias .. = cd ..
alias ... = cd ../..
alias .... = cd ../../..

alias ls = ls --color=auto
alias ll = ls -la
alias la = ls -A

alias grep = grep --color=auto

# ===== FUNCIONES =====
def mkcd [dir: string] {
    mkdir $dir
    cd $dir
}

# ===== EDITOR =====
let-env EDITOR = "nvim"
let-env VISUAL = "nvim"
let-env PAGER = "less"
