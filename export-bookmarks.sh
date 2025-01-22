#!/bin/bash

#TODO: rename old bookmarks to .bookmarks .bak, and then pipe bookmarks through sort -u -r

file="/home/mattias/dirs/Documents/bookmarks/$(ls ~/dirs/Documents/bookmarks/)"

echo $file

#clean=$(nvim --headless -c "g/Trash/norm dG" -c "wqa" $file)

cat $file | grep -Eo $'HREF="[^"]+' | sed 's/HREF="//g' >> ~/dotfiles/sway/scripts/.bookmarks

cat ~/dotfiles/sway/scripts/.bookmarks | sort -u -r > ~/dotfiles/sway/scripts/.bookmarks

rm "$file"
