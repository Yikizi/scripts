#!/bin/bash

export LC_NUMERIC="en_US.UTF-8"

#exec > "/tmp/sway.log" 2>&1

[[ $1 != "i" ]] && playerctl -p spotify volume "0.02$1"
num=$(/usr/bin/playerctl -p spotify volume)
rounded=$(printf "%.2f" $num)
percentage=$(echo "$rounded * 100" | /usr/bin/bc)
notify-send -t 500 "$(printf "%.0f" $percentage)%"
