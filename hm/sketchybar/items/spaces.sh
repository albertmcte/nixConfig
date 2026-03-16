#!/usr/bin/env bash

source "$HOME/.config/sketchybar/variables.sh" # Loads all defined colors

sketchybar --add item spacer.1 left \
	--set spacer.1 background.drawing=off \
	label.drawing=off \
	icon.drawing=off \
	width=10

sketchybar --add event aerospace_workspace_change

IDX=0
for sid in $(/opt/homebrew/bin/aerospace list-workspaces --all); do
    LABEL="${SPACE_ICONS[$IDX]:-$sid}"
    sketchybar --add item space."$sid" left \
        --subscribe space."$sid" aerospace_workspace_change \
        --set space."$sid" \
        updates=on \
        background.color=0x44ffffff \
        background.corner_radius=5 \
        background.height=20 \
        background.drawing=off \
        icon.drawing=off \
        label="$LABEL" \
        click_script="/opt/homebrew/bin/aerospace workspace $sid" \
        script="$PLUGIN_DIR/aerospace.sh $sid"
    IDX=$((IDX + 1))
done

sketchybar --add item spacer.2 left \
	--set spacer.2 background.drawing=off \
	label.drawing=off \
	icon.drawing=off \
	width=5

sketchybar --add bracket spaces '/space.*/' \
	--set spaces background.border_width="$BORDER_WIDTH" \
	background.border_color="$RED" \
	background.corner_radius="$CORNER_RADIUS" \
	background.color="$BAR_BACKGROUND" \
	background.height=26 \
	background.drawing=on

sketchybar --add item separator left \
	\
	icon.font="$FONT:Regular:16.0" \
	background.padding_left=26 \
	background.padding_right=15 \
	label.drawing=off \
	associated_display=active \
	icon.color="$YELLOW" # --set separator icon= \
