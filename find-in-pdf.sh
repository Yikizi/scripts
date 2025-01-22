#!/bin/bash

query=$(rofi -i -dmenu -p "Enter pdf query")

[[ -z $query ]] && exit 0

options=$(rga -i "$query" /home/mattias/dirs/Documents/pdfs/kool)

[[ -z $options ]] && notify-send -t 2000 "No matching pdfs found" && exit 0

selection=$(echo "$options" | sed 's:/home/mattias/dirs/Documents/pdfs/kool/::g' | rofi -i -dmenu -p "Choose pdf")

[[ -z $selection ]] && exit 0

zathura -P "$(echo "$selection" | awk -F : '{print $2}' | tr -d 'Page ')" "/home/mattias/dirs/Documents/pdfs/kool/""$(echo "$selection" | awk -F : '{print $1}')"
