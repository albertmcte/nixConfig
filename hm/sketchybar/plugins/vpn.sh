#!/usr/bin/env bash

TAILSCALE_STATUS=$(/Applications/Tailscale.app/Contents/MacOS/Tailscale status --json 2>/dev/null | jq -r '.BackendState // empty')

if [[ "$TAILSCALE_STATUS" == "Running" ]]; then
  sketchybar --set vpn \
    drawing=on \
    icon=  \
    label="Tailscale Up" 
else
  sketchybar --set vpn drawing=off
fi
