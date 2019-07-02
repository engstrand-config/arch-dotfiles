#!/bin/sh

[ -f "$HOME/.xprofile" ] && . ~/.xprofile

wal -R

exec i3
