#!/bin/bash
data=$(curl "https://juno.taltech.ee/food/index.php/default")

real_diners=$(cat ~/dotfiles/sway/scripts/.diners)

for diner in $real_diners; do
  diner=${diner//_/ }
  echo "# $diner"
  echo ""
  echo "$data" | jq ".[] | select(.diner.name == \"$diner\") | .meals | .[] | .description" | sed -E 's: ?/(.+):":g' | sed -E 's/(.+)/- \1/g'
  echo ""
done
echo "date:"
date +"%Y%m%d"
