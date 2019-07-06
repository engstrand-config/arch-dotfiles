#!/bin/sh

# Set the dunst theme
# Since dunst is started in xprofile, we need to do this before
set-dunst-colors

[ -f "$HOME/.xprofile" ] && . ~/.xprofile

setxkbmap se
wal -R

# Write colors into colors.Xresources so that i3 can access them
echo "*critical: $WAL_CRITICAL" >> ~/.cache/wal/colors.Xresources
echo "*success: $WAL_SUCCESS" >> ~/.cache/wal/colors.Xresources
cp ~/.cache/wal/colors.Xresources ~/.Xresources

# Load the modified resources file in i3 
xrdb ~/.Xresources

exec i3
