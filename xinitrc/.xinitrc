#!/bin/sh

# Keyboard: fast repeat rate
xset r rate 200 50 &

# Merge X resources if present
[ -f ~/.Xresources ] && xrdb merge ~/.Xresources

# Compositor
picom &

# Notification daemon
dunst &

# Status bar
slstatus &

# Wallpaper (place wp.jpeg in ~/Pictures/)
[ -f ~/Pictures/wp.jpeg ] && feh --bg-fill ~/Pictures/wp.jpeg &

exec dwm
