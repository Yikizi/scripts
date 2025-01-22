#!/bin/bash
input="$(zellij action query-tab-names | grep nv- | fzf-launcher "fzf --prompt='Select Zellij tab'")
zellij action go-to-tab-name $input
if [[ $input != "^" ]]; then
  swaymsg [title="zellij"] focus
fi
