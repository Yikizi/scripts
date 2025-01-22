#!/bin/bash

query=$(rofi -dmenu -p "Query")

[[ -n $query ]] && vivaldi --new-tab "duckduckgo.com/?q=$query" && swaymsg [app_id="vivaldi-stable"] focus
