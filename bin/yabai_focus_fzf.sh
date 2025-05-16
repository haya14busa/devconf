#!/usr/bin/env bash

selected=$(yabai -m query --windows | jq -r '.[] | "\(.id)\t\(.app)\t\(.title)"' |
           column -t -s $'\t' |
           fzf --header="ID APP TITLE" |
           awk '{print $1}')

if [[ -n "$selected" ]]; then
    yabai -m window --focus "$selected"
fi
