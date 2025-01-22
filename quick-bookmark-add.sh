#!/bin/bash

wtype yy
sleep 0.1

name=$(wl-paste)

grep "$name" /$HOME/dotfiles/sway/scripts/.bookmarks

[[ $? == 1 ]] && [[ -n $name ]] && echo "$name" >> /home/mattias/dotfiles/sway/scripts/.bookmarks && notify-send -t 2000 "Bookmark added" && exit 0

notify-send -t 1000 "Bookmark already exists!"
