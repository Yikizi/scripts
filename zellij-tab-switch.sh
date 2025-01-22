#!/bin/bash
input="$(zellij action query-tab-names | rofi -i -p "Switch to zellij tab" -dmenu -i)"
zellij action go-to-tab-name "$input"
if [[ $input != "^" ]]; then
  swaymsg [title="zellij"] focus
fi
