#!/bin/bash

choice=$(cat /home/mattias/dotfiles/sway/scripts/.bookmarks | rofi -i -dmenu -p "Bookmarks" | awk '{print $1}')
focused=$(swaymsg -t get_tree | jq '.. | select(.focused? == true) | .app_id')

[[ -z $choice ]] && exit 0
[[ $focused == "firefox-esr" ]] && t "$choice" enter && exit 0
[[ $focused == "vivaldi-stable" ]] && wtype -M ctrl t -m ctrl "$choice" && exit 0
wlrctl keyboard type "$choice"
