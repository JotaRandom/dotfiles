setxkbmap es &
numlockx &
xset +fp /usr/share/fonts/local &
/usr/bin/urxvtd -q -o -f &

exec ck-launch-session dbus-launch wmfs
