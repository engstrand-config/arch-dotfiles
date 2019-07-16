#!/bin/sh

PROFILE_PATH=~/.dotfiles/profiles/$(whoami)
bash $PROFILE_PATH/init 

[ -f "$HOME/.xprofile" ] && . ~/.xprofile

# Set wal colors from cache
wal -R

exec i3
