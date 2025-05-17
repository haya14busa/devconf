#!/usr/bin/env bash

TMPDIR=$(mktemp -d)
trap 'rm -rf -- "$TMPDIR"' EXIT HUP INT TERM

selected=$(yabai -m query --windows | jq -r '.[] | "\(.id)\tspace=\(.space)\t\(.app)\t\(.title)"' |
           column -t -s $'\t' |
           fzf --header="ID SCREEN APP TITLE" --layout=reverse --preview-window=down:80% --preview='(){
             window_id={1}
             screencapture -x -l $window_id '$TMPDIR'/$window_id.png
             dim=${FZF_PREVIEW_COLUMNS}x${FZF_PREVIEW_LINES}
             kitten icat --clear --transfer-mode=memory --unicode-placeholder --stdin=no --place="$dim@0x0" '$TMPDIR'/$window_id.png
           }' |
           awk '{print $1}')

if [[ -n "$selected" ]]; then
    yabai -m window --focus "$selected"
fi
