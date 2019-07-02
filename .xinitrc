#!/bin/sh

[ -f "$HOME/.xprofile" ] && . ~/.xprofile

setxkbmap se
wal -R

exec i3
