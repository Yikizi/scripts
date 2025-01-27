#!/bin/bash

# NOTE: this needs the surfingkeys extension to function correctly
# also works if there are multiple links, it opens them all!
wl-paste | grep -oE "https://[^ ]+" | wl-copy
swaymsg '[app_id="vivaldi-stable"]' focus && wtype cc
