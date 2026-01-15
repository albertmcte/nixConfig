#!/usr/bin/env bash

sketchybar \
	--add item vpn q \
	--set vpn \
	update_freq=15 \
	updates=on \
  icon.drawing=off \
	label.padding_right=10 \
  label.padding_left=10 \
	background.height=26 \
	background.corner_radius="$CORNER_RADIUS" \
	background.padding_right=5 \
	background.border_width="$BORDER_WIDTH" \
	background.color="$BAR_BACKGROUND" \
	background.drawing=on \
	script="$PLUGIN_DIR/vpn.sh"
