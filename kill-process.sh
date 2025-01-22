#!/bin/bash

line=$(ps aux | fzf)
[[ $? != 0 ]] && exit 0
pid=$(echo $line | awk '{print $2}')
command=$(echo $line | awk '{print $NF}')
read -n1 -p "Are you sure you want to kill $command? (Y/n)" ans
[[ "$ans" != "n" ]] && kill -9 $pid && exit 0
exit 1
