#!/bin/bash

bookmarks="$HOME/dotfiles/sway/scripts/.bookmarks"

url=$(cat "$bookmarks" | sed -E 's/[0-9]+ http/http/g' | fzf-launcher "fzf --cycle +s --prompt='Enter your url: '")

url=$(echo "$url" | awk '{print $1}')

[[ -z $url ]] && exit 0

already=$(~/dotfiles/sway/scripts/vivaldi-tabs-rofi.sh "$url")

nvim --headless -c "g|$url|norm ^" -c "wqa" "$bookmarks"

sort -rn -k1 -o "$bookmarks" "$bookmarks"

[[ -n $already ]] && exit 0

vivaldi --new-tab "$url" && swaymsg '[app_id="vivaldi-stable"]' focus

