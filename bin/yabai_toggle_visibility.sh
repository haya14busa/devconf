#!/bin/bash
set -e

TARGET=$1

if [ -z "$TARGET" ]; then
  exit 1
fi

toggle-visibility.scpt "$TARGET"

sleep 0.1

id="$(yabai -m query --windows | jq "map(select(.app == \""$TARGET"\" and .[\"is-visible\"] == true))[-1].id")"

if [ -n "$id" ]; then
  yabai -m window --focus $id
fi
