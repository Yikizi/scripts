#!/bin/bash

tmux has-session -t "leet" &&
  foot -e tmux attach -t leet &&
  exit 0

tmux new-session -s "leet" -d
tmux send-keys -t "leet" "bash" C-m
tmux send-keys -t "leet" "conda activate leettools" C-m
foot -e tmux attach -t leet
exit 0
