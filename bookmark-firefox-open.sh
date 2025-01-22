#!/bin/bash

bookmarks="$HOME/dotfiles/sway/scripts/.bookmarks"

url=$(cat "$bookmarks" | sed -E 's/[0-9]+ http/http/g' | fzf-launcher "fzf +s --prompt='Enter your url: '" )

url=$(echo "$url" | awk '{print $1}')

[[ -z $url ]] && exit 0

firefox-esr --new-tab "$url" && swaymsg '[title="Mozilla Firefox"]' focus

nvim --headless -c "g|$url|norm ^" -c "wqa" "$bookmarks"

sort -rn -k1 -o "$bookmarks" "$bookmarks"
