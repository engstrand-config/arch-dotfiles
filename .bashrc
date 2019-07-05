#!/bin/bash

. "${HOME}/.cache/wal/colors.sh"

stty -ixon # Disable ctrl-s and ctrl-q.
shopt -s autocd #Allows you to cd into directory merely by typing the directory name.
HISTSIZE= HISTFILESIZE= # Infinite history.
export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"

[ -f "$HOME/.config/shortcutrc" ] && source "$HOME/.config/shortcutrc" # Load shortcut aliases
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"

export WAL_LIGHT="$color7"
export WAL_DARK="$color2"
export WAL_0="$color0"
export WAL_1="$color1"
export WAL_3="$color3"
export WAL_4="$color4"
export WAL_5="$color5"
export WAL_6="$color6"

export WAL_SUCCESS="green"
export WAL_CRITICAL="red"
