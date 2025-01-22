#!/bin/bash

export WAYLAND_DISPLAY=wayland-1
export XDG_RUNTIME_DIR=/run/user/1000

prefix="/$HOME/dirs/Documents/backgrounds/"
file=$(ls "/$HOME/dirs/Documents/backgrounds/" | shuf -n 1)
pkill swaybg
/usr/bin/swaybg -i "$prefix$file" && exit 0

if (( $(date +%-H) <= 2 )); then
  pkill swaybg
  /usr/bin/swaybg -i /home/mattias/dirs/Documents/backgrounds/retrowave.jpg
  exit 0
fi
if (( $(date +%-H) <= 6 )); then
  pkill swaybg
  /usr/bin/swaybg -i /home/mattias/dirs/Documents/backgrounds/pixel-morning.jpg
  exit 0
fi
if (( $(date +%-H) <= 8 )); then
  pkill swaybg
  /usr/bin/swaybg -i /home/mattias/dirs/Documents/backgrounds/foggy-mountains.jpg
  exit 0
fi
if (( $(date +%-H) <= 10 )); then
  pkill swaybg
  /usr/bin/swaybg -i /home/mattias/dirs/Documents/backgrounds/sunrise-lake-rocks.jpg
  exit 0
fi
if (( $(date +%-H) <= 12 )); then
  pkill swaybg
  /usr/bin/swaybg -i /home/mattias/dirs/Documents/backgrounds/evening-lake-rocks.jpg
  exit 0
fi
if (( $(date +%-H) <= 14 )); then
  pkill swaybg
  /usr/bin/swaybg -i /home/mattias/dirs/Documents/backgrounds/shanghai-city.jpg
  exit 0
fi
if (( $(date +%-H) <= 16 )); then
  pkill swaybg
  /usr/bin/swaybg -i /home/mattias/dirs/Documents/backgrounds/hong-kong.jpg
  exit 0
fi
if (( $(date +%-H) <= 18 )); then
  pkill swaybg
  /usr/bin/swaybg -i /home/mattias/dirs/Documents/backgrounds/evening-landscape.jpg
  exit 0
fi
if (( $(date +%-H) <= 20 )); then
  pkill swaybg
  /usr/bin/swaybg -i /home/mattias/dirs/Documents/backgrounds/lofi-night-city.jpg
  exit 0
fi
if (( $(date +%-H) <= 22 )); then
  pkill swaybg
  /usr/bin/swaybg -i /home/mattias/dirs/Documents/backgrounds/night-sky.png
  exit 0
fi
if (( $(date +%-H) >= 0 )); then
  pkill swaybg
  /usr/bin/swaybg -i /home/mattias/dirs/Documents/backgrounds/purple-desert.jpg
  exit 0
fi
