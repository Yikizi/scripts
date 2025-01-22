#!/bin/bash

title=$1
command=$2

window=$(swaymsg -t get_tree | jq -r --arg title "$title" '.. | select(.name? == $title) | .id')
visible=$(swaymsg -t get_tree | jq ".. | select(.name? == \"$title\") | .visible")
focused=$(swaymsg -t get_tree | jq ".. | select(.name? == \"$title\") | .focused")
if [ -n "$window" ]; then
  if [[ $focused == "true" ]]; then
    swaymsg "[title=\"$title\"] scratchpad show"
  else
    swaymsg "[title=\"$title\"] focus"
  fi
else
  $command
fi
