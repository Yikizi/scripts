#!/bin/bash
branch=$(git branch -r | grep "origin/dev")
[[ -n $branch ]] && branch="dev"
[[ -z $branch ]] && branch="main"
date +%Hh%Mmin >~/dotfiles/sway/scripts/.time
id=$1
name=$(glab issue ls -O json | jq '.[] | select(.iid == '"$id"') | .title')
branchname=${name// /-} &&
  branchname=${branchname//\"/}
glab mr create -a malinh --wip -i "$id" -b $branch -y &&
  git fetch --prune &&
  git checkout -b "$id-${branchname,,}" origin/"$id-${branchname,,}" # must be qouted to remove the ""
