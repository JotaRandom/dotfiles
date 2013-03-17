#############################################################################
##
## Gentoo's csh.cshrc
##
## Based on the TCSH package (http://tcshrc.sourceforge.net)
## 
## .tcshrc		2Sep2001, Simos Xenitellis (simos@hellug.gr)
##
## 2003-01-13  --  Alain Penders (alain@gentoo.org)
##     Renamed to /etc/csh.cshrc, basic cleanup work.
##
## 2003-01-24  --  Alain Penders (alain@gentoo.org)
##     Improved config file handling.
##
onintr -
##

##
## Load the environment defaults.
##
if ( -r /etc/csh.env ) then
    source /etc/csh.env
endif


##
## Make sure our path includes the basic stuff for root and normal users.
##
if ($LOGNAME == "root") then
    set -f path = ( $path /sbin )
    set -f path = ( $path /usr/sbin )
    set -f path = ( $path /usr/local/sbin )
    set -f path = ( $path /opt/sbin )
endif
set -f path = ( $path /bin )
set -f path = ( $path /usr/bin )
set -f path = ( $path /usr/local/bin )
set -f path = ( $path /opt/bin )


##
## Load our settings -- most are for interactive shells only, but not all.
##
if ( -e /etc/profile.d/tcsh-settings ) then
    source /etc/profile.d/tcsh-settings
endif


##
## Source extensions installed by ebuilds
##
if ( -d /etc/profile.d ) then
  set _tmp=${?nonomatch}
  set nonomatch
  foreach _s ( /etc/profile.d/*.csh )
    if ( -r $_s ) then
      source $_s
    endif
  end
  if ( ! ${_tmp} ) unset nonomatch
  unset _tmp _s
endif


# Everything after this point is interactive shells only.
if ( $?prompt == 0 ) goto end


##
## Load our aliases -- for interactive shells only
##
if ( -e /etc/profile.d/tcsh-aliases ) then
    source /etc/profile.d/tcsh-aliases
endif


##
## Load our key bindings -- for interactive shells only
##
if ( -e /etc/profile.d/tcsh-bindkey ) then
    source /etc/profile.d/tcsh-bindkey
endif


##
## Load our command completions -- for interactive shells only
##
if ( -e /etc/profile.d/tcsh-complete ) then
    source /etc/profile.d/tcsh-complete
endif


end:
##
onintr
##

fortune | sed -e 's/america/amareica/g' -e 's/America/Amareica/g' -e 's/anybody/anypony/g' -e 's/Anybody/Anypony/g' -e 's/anyone/anypony/g' -e 's/Anyone/Anypony/g' -e 's/boy/colt/g' -e 's/Boy/Colt/g' -e 's/butthurt/saddle-sore/g' -e 's/Butthurt/Saddlesore/g' -e 's/children/foals/g' -e 's/Children/Foals/g' -e 's/child/foal/g' -e 's/Child/Foal/g' -e 's/cowboy/cowpony/g' -e 's/Cowboy/Cowpony/g' -e 's/cowgirl/cowpony/g' -e 's/Cowgirl/Cowpony/g' -e 's/gentlemen/gentlecolts/g' -e 's/Gentlemen/Gentlecolts/g' -e 's/everybody/everypony/g' -e 's/Everybody/Everypony/g' -e 's/everyone/everypony/g' -e 's/Everyone/Everypony/g' -e 's/feet/hooves/g' -e 's/Feet/Hooves/g' -e 's/folks/foalks/g' -e 's/Folks/Foalks/g' -e 's/fool/foal/g' -e 's/Fool/Foal/g' -e 's/foot/hoof/g' -e 's/Foot/Hoof/g' -e 's/girls/fillies/g' -e 's/Girls/Fillies/g' -e 's/girl/filly/g' -e 's/Girl/Filly/g' -e 's/halloween/nightmare night/g' -e 's/Halloween/Nightmare Night/g' -e 's/hands/hooves/g' -e 's/Hands/Hooves/g' -e 's/handed/hooved/g' -e 's/Handed/Hooved/g' -e 's/hand/hoof/g' -e 's/Hand/Hoof/g' -e 's/\bhey\b/hay/g' -e 's/\bHey\b/Hay/g' -e 's/humans/ponies/g' -e 's/Humans/Ponies/g' -e 's/human/pony/g' -e 's/Human/Pony/g' -e 's/ladies/fillies/g' -e 's/Ladies/Fillies/g' -e 's/main/mane/g' -e 's/Main/Mane/g' -e 's/woman/mare/g' -e 's/Woman/Mare/g' -e 's/women/mares/g' -e 's/Women/Mares/g' -e 's/\bman\b/stallion\ /g' -e 's/\bMan\b/Stallion/g' -e 's/\bmen\b/stallions/g' -e 's/\bMen\b/Stallions/g' -e 's/no\ one\ else/no\ pony\ else/g' -e 's/No\ one\ else/No\ pony\ else/g' -e 's/nobody/nopony/g' -e 's/Nobody/Nopony/g' -e 's/people/ponies/g' -e 's/People/Ponies/g' -e 's/person/pony/g' -e 's/Person/Pony/g' -e 's/philadelphia/fillydelphia/g' -e 's/Philadelphia/Fillydelphia/g' -e 's/somebody/somepony/g' -e 's/Somebody/Somepony/g' -e 's/tattoo/cutie\ mark/g' -e 's/Tattoo/Cutie\ mark/g' -e 's/the\ heck/the\ hay/g' -e 's/The\ heck/The hay/g' -e 's/the\ hell/the\ hay/g' -e 's/The\ Hell/The\ Hay/g' -e 's/troll/parasprite/g' -e 's/Troll/Parasprite/g' | ponysay -b round -W 70

if ($?prompt) then
	set promptchars = "%#"
	if ($?tcsh) then
		set prompt = "[%m:%c3] %n%# "
	else
		set prompt = "[%m:%c3] `id -nu`%# "
	endif
endif