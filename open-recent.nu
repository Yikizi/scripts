#!/usr/bin/env nu

use my-utils.nu fzf-launch

let data = (open /home/mattias/dotfiles/sway/scripts/.recent)
let cmd = "fzf.sh --wrap --tac"

fzf-launch $data $cmd

if (open --raw /tmp/fzf.status | str trim) == "0" {
  let filename = (open --raw /tmp/fzf.answer | str trim)
  zathura --mode=fullscreen $"(fd -a $filename $env.HOME)"
}

