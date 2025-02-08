#!/usr/bin/env bash

source "$HOME/.config/sketchybar/variables.sh" # Loads all defined colors

SPACE_CLICK_SCRIPT="yabai -m space --focus $SID 2>/dev/null"

WIN=$(yabai -m query --spaces --space $SID | jq '.windows[0]')
HAS_WINDOWS="true"
if [ "$WIN" = "null" ];then
  HAS_WINDOWS="false"
fi
if [ "$SELECTED" = "true" ] ;then
	HAS_WINDOWS="false"
fi
sketchybar --set $NAME background.drawing=on icon.highlight=$HAS_WINDOWS

if [ "$SELECTED" = "true" ]; then
	sketchybar --animate tanh 5 --set "$NAME" \
		icon.color="$RED" \
		icon.highlight_color="$GREEN" \
		icon="${SPACE_ICONS[$SID - 1]}" \
		click_script="$SPACE_CLICK_SCRIPT"
else
	sketchybar --animate tanh 5 --set "$NAME" \
		icon.color="$COMMENT" \
		icon="${SPACE_ICONS[$SID - 1]}" \
		click_script="$SPACE_CLICK_SCRIPT"
fi
