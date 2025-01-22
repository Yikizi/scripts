#!/bin/bash

tui=~/dotfiles/sway/scripts/.tui
term=~/dotfiles/sway/scripts/.term
command=$(tac ~/.zhistory | rofi -dmenu -p "Command")

[[ -z $command ]] && exit 0

grep -q "$command" $tui && kitty -T float -e "$command"

# [[ $? == 1 ]] && grep -q "$command" $term && kitty -T float -e "zsh"

[[ $? == 1 ]] && $command
