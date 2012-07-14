# /etc/bash.bashrc
#
# https://wiki.archlinux.org/index.php/Color_Bash_Prompt
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !

# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.

if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

fortune | sed -e 's/america/amareica/g' -e 's/America/Amareica/g' -e 's/anybody/anypony/g' -e 's/Anybody/Anypony/g' -e 's/anyone/anypony/g' -e 's/Anyone/Anypony/g' -e 's/boy/colt/g' -e 's/Boy/Colt/g' -e 's/butthurt/saddle-sore/g' -e 's/Butthurt/Saddlesore/g' -e 's/children/foals/g' -e 's/Children/Foals/g' -e 's/child/foal/g' -e 's/Child/Foal/g' -e 's/cowboy/cowpony/g' -e 's/Cowboy/Cowpony/g' -e 's/cowgirl/cowpony/g' -e 's/Cowgirl/Cowpony/g' -e 's/gentlemen/gentlecolts/g' -e 's/Gentlemen/Gentlecolts/g' -e 's/everybody/everypony/g' -e 's/Everybody/Everypony/g' -e 's/everyone/everypony/g' -e 's/Everyone/Everypony/g' -e 's/feet/hooves/g' -e 's/Feet/Hooves/g' -e 's/folks/foalks/g' -e 's/Folks/Foalks/g' -e 's/fool/foal/g' -e 's/Fool/Foal/g' -e 's/foot/hoof/g' -e 's/Foot/Hoof/g' -e 's/girls/fillies/g' -e 's/Girls/Fillies/g' -e 's/girl/filly/g' -e 's/Girl/Filly/g' -e 's/halloween/nightmare night/g' -e 's/Halloween/Nightmare Night/g' -e 's/hands/hooves/g' -e 's/Hands/Hooves/g' -e 's/handed/hooved/g' -e 's/Handed/Hooved/g' -e 's/hand/hoof/g' -e 's/Hand/Hoof/g' -e 's/\bhey\b/hay/g' -e 's/\bHey\b/Hay/g' -e 's/humans/ponies/g' -e 's/Humans/Ponies/g' -e 's/human/pony/g' -e 's/Human/Pony/g' -e 's/ladies/fillies/g' -e 's/Ladies/Fillies/g' -e 's/main/mane/g' -e 's/Main/Mane/g' -e 's/woman/mare/g' -e 's/Woman/Mare/g' -e 's/women/mares/g' -e 's/Women/Mares/g' -e 's/\bman\b/stallion\ /g' -e 's/\bMan\b/Stallion/g' -e 's/\bmen\b/stallions/g' -e 's/\bMen\b/Stallions/g' -e 's/no\ one\ else/no\ pony\ else/g' -e 's/No\ one\ else/No\ pony\ else/g' -e 's/nobody/nopony/g' -e 's/Nobody/Nopony/g' -e 's/people/ponies/g' -e 's/People/Ponies/g' -e 's/person/pony/g' -e 's/Person/Pony/g' -e 's/philadelphia/fillydelphia/g' -e 's/Philadelphia/Fillydelphia/g' -e 's/somebody/somepony/g' -e 's/Somebody/Somepony/g' -e 's/tattoo/cutie\ mark/g' -e 's/Tattoo/Cutie\ mark/g' -e 's/the\ heck/the\ hay/g' -e 's/The\ heck/The hay/g' -e 's/the\ hell/the\ hay/g' -e 's/The\ Hell/The\ Hay/g' -e 's/troll/parasprite/g' -e 's/Troll/Parasprite/g' | ponysay

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

# Enable history appending instead of overwriting.  #139609
shopt -s histappend

case ${TERM} in
  xterm*|rxvt*|Eterm|aterm|kterm|gnome*)
    PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"'
    ;;
  screen)
    PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033_%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"'
    ;;
esac

# Fortune is a simple program that displays a pseudorandom message
# from a database of quotations at logon and/or logout;
# type: "pacman -S fortune-mod" to install it, then uncomment the
# following lines:

# if [ "$PS1" ]; then
#	/usr/bin/fortune
# fi

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.

# Dynamically modified variables. Do not change them!
use_color=false
# sanitize TERM:
safe_term=${TERM//[^[:alnum:]]/?}
match_lhs=""

[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs}    ]] \
	&& type -P dircolors >/dev/null \
	&& match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

if ${use_color} ; then
	# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
	if type -P dircolors >/dev/null ; then
		if [[ -f ~/.dir_colors ]] ; then
			eval $(dircolors -b ~/.dir_colors)
		elif [[ -f /etc/DIR_COLORS ]] ; then
			eval $(dircolors -b /etc/DIR_COLORS)
		fi
	fi

	if [[ ${EUID} == 0 ]] ; then
		PS1='\[\e[0;31m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[0;31m\]\$\[\e[m\] \[\e[1;37m\]'
	else
		PS1='\[\e[0;32m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]\$\[\e[m\] \[\e[1;37m\]'
	fi

	alias ls='ls --color=auto'
	alias ll='ls -l --color=auto'
	alias la='ls -a --color=auto'
	alias dir='dir --color=auto'
	alias grep='grep --colour=auto'
else
	if [[ ${EUID} == 0 ]] ; then
		# show root@ when we do not have colors
		PS1='\u@\h \W \$ '
	else
		PS1='\u@\h \w \$ '
	fi
fi





PS2='> '
PS3='> '
PS4='+ '

# Try to keep environment pollution down, EPA loves us.
unset use_color safe_term match_lhs

[ -r /etc/bash_completion ] && . /etc/bash_completion