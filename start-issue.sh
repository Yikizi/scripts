#!/bin/bash
date +%Hh%Mmin >~/dotfiles/sway/scripts/.time
id=$1
name=$(glab issue ls -O json | jq '.[] | select(.iid == '"$id"') | .title')
branchname=${name// /-} &&
  branchname=${branchname//\"/}
glab mr create -a malinh --wip -i "$id" -b dev -y &&
  git fetch --prune &&
  git checkout -b "$id-${branchname,,}" origin/"$id-${branchname,,}" # must be qouted to remove the ""
