#!/usr/bin/env bash
set -e
existings="$(yabai -m query --windows | jq -r 'map(select(.app == "Ghostty").id) | .[]')"

RECENT_SPACE_TYPE=$(yabai -m query --spaces --space | jq -r .type)
yabai -m space --layout float
yabai -m signal --add event=window_created label=___FOCUS_FZF___ app=Ghostty \
  action='yabai -m window --focus $YABAI_WINDOW_ID --toggle float --grid 5:5:1:1:3:3 && yabai -m signal --remove ___FOCUS_FZF___'
open -na Ghostty --args --title="___FOCUS_FZF___" -e "${HOME}/bin/yabai_focus_fzf.sh" 
sleep 0.1
yabai -m space --layout "$RECENT_SPACE_TYPE"
