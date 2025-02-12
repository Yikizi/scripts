#!/bin/bash

file="/home/mattias/dotfiles/sway/scripts/.recent"

echo "$(basename $1)" >>/home/mattias/dotfiles/sway/scripts/.recent
/usr/bin/nu -c "open $file | split row "\n" | uniq | last 25 | collect | save -f $file"

zathura "$@"
