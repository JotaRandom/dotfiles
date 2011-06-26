#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)
xset +fp /usr/share/fonts/local &
/usr/bin/urxvtd -q -o -f &
setxkbmap es &
numlockx &
(sleep 1 && nitrogen --restore) &
mmaker icewm --no-debian --no-legacy -f -t xterm &

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# exec gnome-session
# exec startkde
# exec startxfce4
# ...or the Window Manager of your choice

exec ck-launch-session dbus-launch icewm-session
