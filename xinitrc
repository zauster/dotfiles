#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)


if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources


exec awesome
( ( sleep 10 && /usr/bin/xscreensaver -no-splash -display :0.0 ) & )

# start some programs
# sleep 2 && dropbox &
# connman-ui-gtk &
# connman-notify &
# bluemanmanager &
# redshift-gtk &

