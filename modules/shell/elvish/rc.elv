# ~/.elvish/rc.elv - Elvish Shell optimizado para ThinkPad L420 (1366x768)

# ===== PROMPT COMPACTO =====
# Prompt simple de 1 línea
set edit:prompt = {
    styled (whoami)@(hostname): green
    styled (tilde-abbr $pwd) blue
    styled '$ ' green
}

# ===== HISTORY =====
# Reducido para ThinkPad
set edit:max-height = 5000

# ===== ALIASES =====
fn .. { cd .. }
fn ... { cd ../.. }
fn .... { cd ../../.. }

fn ls [@a]{ e:ls --color=auto -h $@a }
fn ll [@a]{ ls -la $@a }
fn la [@a]{ ls -A $@a }

fn grep [@a]{ e:grep --color=auto $@a }

# ===== EDITOR =====
set E:EDITOR = nvim
set E:VISUAL = nvim
set E:PAGER = less

# ===== FUNCIONES =====
fn mkcd [dir]{
    mkdir -p $dir
    cd $dir
}
