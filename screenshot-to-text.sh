#!/bin/bash

[[ "$1" == "raw" ]] && grim -g "$(swaymsg -t get_tree | jq -r '.. | select(.pid? and .visible?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"' | slurp)" - | tesseract - - -l est | wl-copy && exit 0

mime_type=$(wl-paste --list-types | grep "image")

[[ -z "$mime_type" ]] && notify-send -t 2000 "No image in clipboard" && exit 0

[[ "$1" == "clip" ]] && wl-paste | tesseract - - -l est | wl-copy && exit 0
