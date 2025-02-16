#!/bin/bash

wtype yy
sleep 0.1

name=$(wl-paste)

grep "$name" $HOME/dotfiles/sway/scripts/.bookmarks
echo bm add "$name" >/tmp/scriptfile

[[ $? == 1 ]] && [[ -n $name ]] && nu -l -c "$(cat /tmp/scriptfile)" && notify-send -t 2000 "Bookmark added" && rm /tmp/scriptfile && exit 0

notify-send -t 1000 "Bookmark already exists!"
