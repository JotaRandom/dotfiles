# set screen window name
if [[ $TERM == "screen" ]]; then
    preexec() { echo -ne "\033k$1\033\\" }
fi

# Initial pony fortune or pony alone
#fortune | sed -e 's/america/amareica/g' -e 's/America/Amareica/g' -e 's/anybody/anypony/g' -e 's/Anybody/Anypony/g' -e 's/anyone/anypony/g' -e 's/Anyone/Anypony/g' -e 's/boy/colt/g' -e 's/Boy/Colt/g' -e 's/butthurt/saddle-sore/g' -e 's/Butthurt/Saddlesore/g' -e 's/children/foals/g' -e 's/Children/Foals/g' -e 's/child/foal/g' -e 's/Child/Foal/g' -e 's/cowboy/cowpony/g' -e 's/Cowboy/Cowpony/g' -e 's/cowgirl/cowpony/g' -e 's/Cowgirl/Cowpony/g' -e 's/gentlemen/gentlecolts/g' -e 's/Gentlemen/Gentlecolts/g' -e 's/everybody/everypony/g' -e 's/Everybody/Everypony/g' -e 's/everyone/everypony/g' -e 's/Everyone/Everypony/g' -e 's/feet/hooves/g' -e 's/Feet/Hooves/g' -e 's/folks/foalks/g' -e 's/Folks/Foalks/g' -e 's/fool/foal/g' -e 's/Fool/Foal/g' -e 's/foot/hoof/g' -e 's/Foot/Hoof/g' -e 's/girls/fillies/g' -e 's/Girls/Fillies/g' -e 's/girl/filly/g' -e 's/Girl/Filly/g' -e 's/halloween/nightmare night/g' -e 's/Halloween/Nightmare Night/g' -e 's/hands/hooves/g' -e 's/Hands/Hooves/g' -e 's/handed/hooved/g' -e 's/Handed/Hooved/g' -e 's/hand/hoof/g' -e 's/Hand/Hoof/g' -e 's/\bhey\b/hay/g' -e 's/\bHey\b/Hay/g' -e 's/humans/ponies/g' -e 's/Humans/Ponies/g' -e 's/human/pony/g' -e 's/Human/Pony/g' -e 's/ladies/fillies/g' -e 's/Ladies/Fillies/g' -e 's/main/mane/g' -e 's/Main/Mane/g' -e 's/woman/mare/g' -e 's/Woman/Mare/g' -e 's/women/mares/g' -e 's/Women/Mares/g' -e 's/\bman\b/stallion\ /g' -e 's/\bMan\b/Stallion/g' -e 's/\bmen\b/stallions/g' -e 's/\bMen\b/Stallions/g' -e 's/no\ one\ else/no\ pony\ else/g' -e 's/No\ one\ else/No\ pony\ else/g' -e 's/nobody/nopony/g' -e 's/Nobody/Nopony/g' -e 's/people/ponies/g' -e 's/People/Ponies/g' -e 's/person/pony/g' -e 's/Person/Pony/g' -e 's/philadelphia/fillydelphia/g' -e 's/Philadelphia/Fillydelphia/g' -e 's/somebody/somepony/g' -e 's/Somebody/Somepony/g' -e 's/tattoo/cutie\ mark/g' -e 's/Tattoo/Cutie\ mark/g' -e 's/the\ heck/the\ hay/g' -e 's/The\ heck/The hay/g' -e 's/the\ hell/the\ hay/g' -e 's/The\ Hell/The\ Hay/g' -e 's/troll/parasprite/g' -e 's/Troll/Parasprite/g' | ponysay -b round -W 70
ponysay -o

# Not sure why I put this, meh
DEBEMAIL="prflr88@gmail.com"
DEBFULLNAME="Pablo Lezaeta"

# editor options
EDITOR=zile
VISUAL=$EDITOR

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Proper keyboard configuration
autoload zkbd
[[ ! -d ~/.zkbd ]] && mkdir ~/.zkbd
[[ ! -f ~/.zkbd/$TERM-${DISPLAY:-$VENDOR-$OSTYPE} ]] && zkbd
source  ~/.zkbd/$TERM-${DISPLAY:-$VENDOR-$OSTYPE}
[[ -n "${key[Home]}"   ]] && bindkey "${key[Home]}"   beginning-of-line
[[ -n "${key[End]}"    ]] && bindkey "${key[End]}"    end-of-line
[[ -n "${key[Insert]}" ]] && bindkey "${key[Insert]}" overwrite-mode
[[ -n "${key[Delete]}" ]] && bindkey "${key[Delete]}" delete-char
[[ -n "${key[Up]}"     ]] && bindkey "${key[Up]}"     up-line-or-history
[[ -n "${key[Down]}"   ]] && bindkey "${key[Down]}"   down-line-or-history
[[ -n "${key[Left]}"   ]] && bindkey "${key[Left]}"   backward-char
[[ -n "${key[Right]}"  ]] && bindkey "${key[Right]}"  forward-char

unset RPS1

# History set...yep I like have those weird numbers 
HISTSIZE=1048576
SAVEHIST=1048576
setopt HIST_IGNORE_ALL_DUPS
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE
HISTFILE=~/.zsh-history

# if you want to setup ssh key logins (and use ssh-add)
# ~/bin/sudo: cd $1; shift; if [ "x${1}" = "x" ]; then $SHELL; else $@; fi
#alias su='ssh -t root@$HOST /usr/bin/sudo `pwd`'
#alias sudo='ssh -t root@$HOST /usr/bin/sudo `pwd` 2>/dev/null'

# Enable color support of ls and grep
if [ -x /usr/bin/dircolors ]; then
	eval `dircolors -b`
	alias ls="ls --color=auto -F -X"
	alias dir="dir --color=auto"
	alias vdir="vdir --color=auto"
fi

# More colors
if [ -x /usr/bin/grc ]; then
	alias ping="grc --colour=auto ping"
	alias traceroute="grc --colour=auto traceroute"
	alias netstat="grc --colour=auto netstat"
fi
if [ -x /usr/bin/colortail ]; then
	alias tail="colortail"
fi
if [ -x /usr/bin/colordiff ]; then
	alias diff="colordiff -Naur"
fi

# Color man
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
export PATH="$PATH:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/local/lib:/usr/lib:/lib:/opt"

# Human file sizes
alias df="df -Th"
alias du="du -hc"

# man zshoptions
setopt nonomatch
setopt inc_append_history

# General configuration
setopt EXTENDED_GLOB
setopt CORRECT_ALL
setopt AUTO_CD
setopt CLOBBER
setopt BRACE_CCL
unsetopt BEEP
autoload -U colors && colors

# Completion basic
autoload -Uz compinit && compinit
setopt AUTO_PARAM_SLASH
setopt LIST_TYPES
setopt COMPLETE_IN_WORD

# URL magic
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

# Tweaking vcs_info before load
autoload -Uz vcs_info
zstyle ':vcs_info:*' stagedstr '§'
zstyle ':vcs_info:*' unstagedstr '±'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b:%r'
zstyle ':vcs_info:*' enable git svn bzr hg cvs

# Systemd aliases or any like it
start()	  {sudo systemctl start $1.service}
restart() {sudo systemctl restart $1.service}
stop()	  {sudo systemctl stop $1.service}
enable()  {sudo systemctl enable $1.service}
status()  {sudo systemctl status $1.service}
disable() {sudo systemctl disable $1.service}

# Workaround precmd change by mc (part 1)
fakeprecmd () { }

# Prompts
precmd () {
# Indicate that shell is running under Midnight Commander
	[ "$MC_SID" ] && psvar[1]="[mc]" || psvar[1]=""
# Further vcs_info tweaks and actual loading
	if [[ -z $(git ls-files --other --exclude-standard 2> /dev/null) ]] {
		zstyle ':vcs_info:*' formats '[%b%c%u]'
	} else {
		zstyle ':vcs_info:*' formats '[%b%c%u¿]'
	}
	vcs_info
	psvar[2]="$vcs_info_msg_0_"
# Workaround precmd change by mc (part 2)
	fakeprecmd
}

# Fancy prompts
PROMPT="%B%1v[%{$fg[yellow]%}%m%{$reset_color%}][%{$fg[green]%}%~%{$reset_color%}]%2v%b%# "
[ "$MC_SID" ] && RPROMPT="" || RPROMPT="[%B%?%b] (%B%T - %D%b)"

# Workaround precmd change by mc (part 3)
alias precmd="noglob fakeprecmd"

# All export come here
export EDITOR VISUAL
export DEBEMAIL DEBFULLNAME
export GREP_OPTIONS="--color=auto --binary-files=without-match --devices=skip"

# Allow root to use my DISPLAY
if [ -n "$DISPLAY" ]; then
	xhost + 2>&1 1>/dev/null
fi

# Completion and higlight everywhere
fpath=(/usr/share/zsh/site-functions $fpath)
