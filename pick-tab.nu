#!/usr/bin/env nu

def main [] {
  use my-utils.nu fzf-launch
  let json = (http get http://localhost:9222/json/list | where type == "page")
  let lines = ($json | select url title | to csv -s " " -n)
  let cmd = "fzf.sh --history=/home/mattias/history/tabs.fzf --wrap --cycle --bind 'enter:execute-silent(wl-copy --primary {})+accept'"
  let result = (fzf-launch $lines $cmd | str trim)
  if $result == "130" { exit 0 }
  let url = (wl-paste --primary | split column " " | get column1 | to text -n)
  let id = ($json | where url == $url | get id | to text -n)
  http get $"http://localhost:9222/json/activate/($id)"
  swaymsg '[app_id="vivaldi-stable"]' focus
}
