#!/bin/bash

file=$1

attatch=$(grep -Eo "_.+.png" "$file")

for line in $attatch; do
  path=$(fd "$line" ~/Sync/org/.attach/)
  id=$(echo "$path" | awk -F '/' '{print $7$8}')
  nvim --headless -c "g/$line/norm O:PROPERTIES::ID:	$id:END:" -c "wqa" "$file"
done
