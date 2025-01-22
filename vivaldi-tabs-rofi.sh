#!/bin/bash

TABS_JSON=$(curl -s http://localhost:9222/json/list)

TABS=$(echo "$TABS_JSON" | jq -r ".[] | select(.type == \"page\") |\"\(.url) \(.id)\"" | sed -E 's/([A-Z0-9]{32})/\\\1^/g' | tr ' ' '_' | tr '\\' ' ' | tr '^' ' ')

key=""
declare -A title_id_map

for tab in $TABS; do
  if [[ $key == "" ]]; then
    key=$tab
    continue
  fi
  title_id_map[$key]=$tab
  key=""
done

SELECTED_TAB=$(echo "${!title_id_map[@]}" | tr ' ' '\n' | tr '_' ' ' | fzf-launcher "fzf --query=$1 -0 -1 --prompt='Switch to Vivaldi tab: '")

real_key="$(echo $SELECTED_TAB | tr ' ' '_')_"

if [ -n "$SELECTED_TAB" ]; then
  curl -s "http://localhost:9222/json/activate/${title_id_map[$real_key]}"
  swaymsg [app_id="vivaldi-stable"] focus
fi
