#!/usr/bin/bash
 
# TOKEN INFORMATION 
_token="$secret"
_user="$secret"

[[ "$2" != "" ]] && curl -s -F "token=${_token}" -F "user=${_user}" -F "title=$1" -F "message=$2" https://api.pushover.net/1/messages.json

exit 0
