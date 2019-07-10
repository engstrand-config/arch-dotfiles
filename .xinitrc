#!/bin/sh

[ -f "$HOME/.xprofile" ] && . ~/.xprofile

# Set wal colors from cache
wal -R

exec i3
