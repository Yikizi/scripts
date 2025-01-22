#!/bin/bash

TABS_JSON=$(curl -s http://localhost:9224/json/list)
#echo $TABS_JSON | fx

TABS=$(echo "$TABS_JSON" | jq -r '.[] | select(.type == "page") |"\(.url) \(.id)"')


key=""
declare -A url_id_map

for tab in $TABS; do
  if [[ $key == "" ]]; then
    key=$tab
    continue
  fi
  url_id_map[$key]=$tab
  key=""
done

#for el in "${!url_id_map[@]}"; do
#  echo "Key: $el, Value: ${url_id_map[$el]}"
#done

SELECTED_TAB=$(echo "${!url_id_map[@]}" | tr ' ' '\n' | fzf-launcher "fzf --prompt='Switch to firefox tab: '")

if [ -n "$SELECTED_TAB" ]; then
    curl -s "http://localhost:9224/json/activate/${url_id_map[$SELECTED_TAB]}"
    swaymsg [app_id="firefox-esr"] focus

fi
