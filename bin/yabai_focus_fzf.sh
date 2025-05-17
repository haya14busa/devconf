#!/usr/bin/env bash

selected=$(yabai -m query --windows | jq -r '.[] | "\(.id)\t\(.app)\t\(.title)"' |
           column -t -s $'\t' |
           gum filter --fuzzy |
           awk '{print $1}')
           # fzf --header="ID APP TITLE" |

if [[ -n "$selected" ]]; then
    yabai -m window --focus "$selected"
fi
