#!/bin/bash

#pass=$(zenity --password --title "Enter your password:")
img=$(sxiv -t -o -N "background-picker" $HOME/dirs/Documents/backgrounds/*)

if [[ -n $img ]]; then
  sudo pkill swaybg
  swaybg -i "$img" &
fi
