#!/bin/bash

grep "$(date +"%Y%m%d")" ~/taltech/scripts/toit.md && cache=true

[[ $? == 1 ]] && ~/taltech/scripts/parse-food.sh | sponge ~/taltech/scripts/toit.md

[[ $? == 0 || $cache == true ]] && kitty -T menüü -e nvim ~/taltech/scripts/toit.md
