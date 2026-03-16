#!/usr/bin/env bash

source "$HOME/.config/sketchybar/variables.sh" # Loads all defined colors

FOCUSED_WORKSPACE=$(aerospace list-workspaces --focused 2>/dev/null)
CURRENT_SID=${NAME##*.} # extract workspace number from item name (space.1 -> 1)

# Check if this workspace has windows
WIN_COUNT=$(aerospace list-windows --workspace "$CURRENT_SID" 2>/dev/null | wc -l | tr -d ' ')
HAS_WINDOWS="false"
if [ "$WIN_COUNT" -gt 0 ]; then
	HAS_WINDOWS="true"
fi

if [ "$FOCUSED_WORKSPACE" = "$CURRENT_SID" ]; then
	# Active workspace — RED
	sketchybar --animate tanh 5 --set "$NAME" \
		icon.color="$RED" \
		icon="${SPACE_ICONS[$CURRENT_SID - 1]}"
elif [ "$HAS_WINDOWS" = "true" ]; then
	# Inactive but has windows — GREEN
	sketchybar --animate tanh 5 --set "$NAME" \
		icon.color="$GREEN" \
		icon="${SPACE_ICONS[$CURRENT_SID - 1]}"
else
	# Inactive and empty — COMMENT (muted gray)
	sketchybar --animate tanh 5 --set "$NAME" \
		icon.color="$COMMENT" \
		icon="${SPACE_ICONS[$CURRENT_SID - 1]}"
fi
