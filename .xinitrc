#!/bin/sh

PROFILE_PATH=~/.dotfiles/profiles/$(whoami)
bash $PROFILE_PATH/init

[ -f "$HOME/.xprofile" ] && . ~/.xprofile

xrdb ~/.Xresources

exec dwm-launcher

eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK
