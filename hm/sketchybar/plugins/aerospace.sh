#!/usr/bin/env bash

source "$HOME/.config/sketchybar/variables.sh"

SID="$1"
WIN_COUNT=$(/opt/homebrew/bin/aerospace list-windows --workspace "$SID" 2>/dev/null | wc -l | tr -d ' ')

if [ "$SID" = "$FOCUSED_WORKSPACE" ]; then
      sketchybar --set "$NAME" label.color="0xff0026E6"
  elif [ "$WIN_COUNT" -gt 0 ]; then
      sketchybar --set "$NAME" label.color="$RED"
  else
      sketchybar --set "$NAME" label.color="$LABEL_COLOR"
fi
