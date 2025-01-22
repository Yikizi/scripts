#!/bin/bash

current_workspace=$(swaymsg -t get_workspaces | jq '.[] | select(.focused == true).num')

#total_workspaces=$(swaymsg -t get_workspaces | jq 'length')

smallest_workspace=$(swaymsg -t get_workspaces | jq '.[-1] | .name')

if [ "$current_workspace" -le 1 ]; then
    swaymsg workspace $smallest_workspace
else
    swaymsg workspace prev
fi
