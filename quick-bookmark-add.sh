#!/bin/bash

wtype yy
sleep 0.1

name=$(wl-paste)

grep "$name" $HOME/dotfiles/sway/scripts/.bookmarks

[[ $? == 1 ]] && [[ -n $name ]] && nu $HOME/dotfiles/sway/scripts/bookmarks.nu add "$name" && notify-send -t 2000 "Bookmark added" && exit 0

notify-send -t 1000 "Bookmark already exists!"
