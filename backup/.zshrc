# set screen window name
if [[ $TERM == "screen" ]]; then
    preexec() { echo -ne "\033k$1\033\\" }
fi

#DEBEMAIL="gurkan@phys.ethz.ch"; export DEBEMAIL
#DEBFULLNAME="Gürkan Sengün"; export DEBFULLNAME
EDITOR=nano; export EDITOR
export PS1='%n@%m:%~%(!.#.$) '
unset RPS1
HISTSIZE=1048576
SAVEHIST=1048576
HISTFILE=~/.history

# if you want to setup ssh key logins (and use ssh-add)
# ~/bin/sudo: cd $1; shift; if [ "x${1}" = "x" ]; then $SHELL; else $@; fi
#alias su='ssh -t root@$HOST ~/bin/sudo `pwd`'
#alias sudo='ssh -t root@$HOST ~/bin/sudo `pwd` 2>/dev/null'

alias less="less -r"

# man zshoptions
setopt nonomatch
setopt inc_append_history
