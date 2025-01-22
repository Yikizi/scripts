#!/bin/bash

# [[ -n "$1" ]] && geo=$(slurp)

# [[ -n "$geo" ]] && wf-recorder -g "$geo" --muxer=v4l2 --codec=rawvideo --file=/dev/video10 -x yuv420p

wf-recorder --muxer=v4l2 --codec=rawvideo --file=/dev/video10 -x yuv420p -o eDP-1 &
