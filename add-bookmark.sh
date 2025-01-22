#!/bin/bash

name=$(fzf-launcher "fzf --prompt='Add bookmark: '")

grep "$name" /home/mattias/dotfiles/sway/scripts/.bookmarks

[[ $? == 1 ]] && [[ -n $name ]] && echo "0 $name" >> /home/mattias/dotfiles/sway/scripts/.bookmarks && notify-send -t 2000 "Bookmark added" && exit 0

notify-send -t 1000 "Bookmark already exists!"
