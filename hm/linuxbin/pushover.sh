#!/usr/bin/env nix-shell
#!nix-shell -i bash -p bash

# Read credentials from agenix secrets
_token="$(cat "$HOME/.agenix/agenix/pushover_token")"
_user="$(cat "$HOME/.agenix/agenix/pushover_user")"

[[ "$2" != "" ]] && curl -s -F "token=${_token}" -F "user=${_user}" -F "title=$1" -F "message=$2" https://api.pushover.net/1/messages.json

exit 0
