#!/bin/sh

xrdb merge ~/.Xresources
xbacklight -set 10 &
feh --bg-fill ~/Pictures/wp.jpeg &
xset r rate 200 50 &
picom &

# dash ~/.config/chadwm/scripts/bar.sh &
# exec dwm
exec slstatus &
exec dwm
# while type dwm >/dev/null; do dwm && continue || break; done
