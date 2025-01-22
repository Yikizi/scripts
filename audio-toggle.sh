#!/bin/bash

last=$(cat ~/dotfiles/sway/scripts/.last-player | awk '{print $1}')
time=$(cat ~/dotfiles/sway/scripts/.last-player | awk '{print $2}')
now=$(date +%s)
diff=$((now - time))
# NOTE: maybe have 5 seconds for cumulative sum that equals the command
# TODO: do something cool with the different time intervals
# notify-send $diff
# ((diff == 3)) && notify-send "fast!!"
[[ $(playerctl -a status | grep Playing) ]] && playerctl -a pause &&
  echo "$last $now" >~/dotfiles/sway/scripts/.last-player && exit 0
[[ $last == 0 ]] && new="chromium"
[[ $last == -1 ]] && new="spotify"
playerctl -p $new play
echo "$((~last)) $now" >~/dotfiles/sway/scripts/.last-player
