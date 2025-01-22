#!/bin/bash

input=$(/usr/bin/rofi-tmux sw)
title=$(swaymsg -t get_tree | jq '.. | select(.focused? == true)' | jq -r '.name')
if [[ $title != "term-scratchpad" ]]; then # add continional or if my secondary tmux window is focused then do not bring up the scratchpad
  swaymsg [title="tmux"] focus
fi
