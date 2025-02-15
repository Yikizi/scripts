#!/bin/bash
# echo $(date) to a file to automatically track time spent
branch=$(git branch -r | grep "origin/dev")
[[ -n $branch ]] && branch="dev"
[[ -z $branch ]] && branch="main"
date +%Hh%Mmin >~/dotfiles/sway/scripts/.time
glab issue create -a malinh -e "$2" -t "$1" -y -d "$3" &&
  id=$(glab issue ls --search "$1" --in title -F ids) &&
  branchname=${1// /-} &&
  glab mr create -a malinh --wip -i "$id" -b $branch -y &&
  git fetch --prune &&
  git checkout -b "$id-$branchname" origin/"$id-$branchname"
