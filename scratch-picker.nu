#!/usr/bin/env -S nu --stdin

use my-utils.nu fzf-launch
let data = (^swayr get-windows-as-json --include-scratchpad --matching '[floating]' | from json)
let lines = ($data | select name | to csv -s " " -n)
let cmd = "fzf.sh --cycle --wrap"
let output = (fzf-launch $lines $cmd | str trim)
let answer = (open --raw /tmp/fzf.answer | str trim)
if ($output != "0") {exit 1}
print $answer
swaymsg $"[title=($answer)]" focus
