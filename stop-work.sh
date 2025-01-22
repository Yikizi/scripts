#!/bin/bash
start=$(cat ~/dotfiles/sway/scripts/.time)
end=$(date +%Hh%Mmin)
time=$(qalc -t "$end - $start" | sed -E 's/[ +]//g')
branch=$(git rev-parse --abbrev-ref HEAD) &&
  issueid=$(echo "$branch" | awk -F '-' '{print $1}') &&
  mrid=$(glab mr ls -s "$branch" -F json | jq '.[] | .iid') &&
  glab issue update "$issueid" -d "/spend $time" &&
  glab mr update "$mrid" -r --reviewer "$1" --squash-before-merge --remove-source-branch
glab issue close "$issueid"
