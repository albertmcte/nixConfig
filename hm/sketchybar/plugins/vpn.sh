#!/usr/bin/env bash

source "$HOME/.config/sketchybar/variables.sh"

TAILSCALE_BIN="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
STATUS_JSON=$($TAILSCALE_BIN status --json 2>/dev/null)
BACKEND_STATE=$(echo "$STATUS_JSON" | jq -r '.BackendState // empty')
EXIT_NODE=$(echo "$STATUS_JSON" | jq -r '.ExitNodeStatus')
if [[ "$BACKEND_STATE" != "Running" ]]; then
  # Tailscale is down
  sketchybar --set vpn \
    drawing=on \
    icon= \
    label="Tailscale Down" \
    icon.color="$RED" \
    label.color="$RED" \
    background.border_color="$RED"
else
  if [[ "$EXIT_NODE" == "null" ]]; then
    # Connected but exit node not used
    sketchybar --set vpn \
      drawing=on \
      icon= \
      label="Tailscale DNS" \
      icon.color="$ORANGE" \
      label.color="$ORANGE" \
      background.border_color="$ORANGE"
  else
    # Exit node used
    sketchybar --set vpn \
      drawing=on \
      icon= \
      label="Tailscale Secure" \
      icon.color="$GREEN" \
      label.color="$GREEN" \
      background.border_color="$GREEN"
  fi
fi
