#!/bin/bash

silent=false
while getopts "sp:" opt; do
    case $opt in
        s) silent=true ;;
        p) query=$OPTARG ;;
        *) ;;
    esac
done

[[ -z $query ]] && query=$(rofi -i -dmenu show -p "Prompt the AI")

if [[ -n $query ]]; then
  zellij action go-to-tab-name "gpt"
  zellij action write-chars "$query"
  zellij action write-chars ""
else
  exit 0
fi

$silent && echo "doing nothing" > /dev/null || swaymsg '[title="zellij"]' focus
