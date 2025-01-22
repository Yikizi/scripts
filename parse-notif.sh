#!/bin/bash

while read line; do
  sender=$(echo $line | grep "summary:" | awk '{print $2}')
  text=$(echo $line | grep "body:")
  todo=$(echo $line | grep "TODO: ")
  body=$(echo $todo | sed 's/TODO: //g' | tr -d "'\n" | head -n1)
  clean=$(echo $body | grep -v "body:")
  # [[ -n "$todo" ]] && echo $(echo $body | grep -v "body:")
  [[ -n "$todo" ]] && task add "$clean" +discord
done
