# set screen window name
if [[ $TERM == "screen" ]]; then
    preexec() { echo -ne "\033k$1\033\\" }
fi

if [ ! -s $DISPLAY ]
then
	command ponysay $(uname -a)
else
	command cowsay $(uname -a)
fi

#DEBEMAIL="gurkan@phys.ethz.ch"; export DEBEMAIL
#DEBFULLNAME="Gürkan Sengün"; export DEBFULLNAME
EDITOR=mcedit; export EDITOR
export PS1='%n@%m:%~%(!.#.$) '
unset RPS1
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.history

# if you want to setup ssh key logins (and use ssh-add)
# ~/bin/sudo: cd $1; shift; if [ "x${1}" = "x" ]; then $SHELL; else $@; fi
#alias su='ssh -t root@$HOST ~/bin/sudo `pwd`'
#alias sudo='ssh -t root@$HOST ~/bin/sudo `pwd` 2>/dev/null'

alias less="less -r"

# man zshoptions
setopt nonomatch
setopt inc_append_history
