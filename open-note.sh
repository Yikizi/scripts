#!/bin/bash

notes=$(ls ~/Sync/notes -Rp | grep '.md$' | grep -v -e : -e '^$' -e '/$' | tr ' ' '\n' )

selected=$(printf "$notes" | rofi -i -dmenu -p "Pick a note")

# path=$(locate "$selected" | grep Sync/)

if [[ -n $selected ]]; then
  swaymsg [title="zellij"] focus

  #tab=$(zellij action query-tab-names | grep $selected)

  zellij action go-to-tab-name -c notes
  /home/mattias/.local/bin/nvr "$HOME/Sync/notes/$selected"
  #nvr --remote-send ":ObsidianQuickSwitch<CR>"
  #nvr --remote-send "$selected"
  #nvr --remote-send "<CR>"

  #if [[ -n $tab ]]; then
  #  exit 0
  #fi

  #zellij action edit $path && zellij action move-focus left && zellij action close-pane

fi
