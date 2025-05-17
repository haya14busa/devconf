#!/usr/bin/env bash
set -e
TERMINAL_APP='Ghostty'
yabai -m rule --add --one-shot app="^${TERMINAL_APP}$" manage=off grid=9:8:1:1:6:7
open -na "$TERMINAL_APP" --args --title="___FOCUS_FZF___" -e "${HOME}/bin/yabai_focus_fzf.sh"
