#!/usr/bin/bash
 
# TOKEN INFORMATION 
_token="aw67793jrm6od4o4cuj22k8eyzbsvv"
_user="upbPWd5HuMNt1EHuf2GWHN1GzDcrGj"

[[ "$2" != "" ]] && curl -s -F "token=${_token}" -F "user=${_user}" -F "title=$1" -F "message=$2" https://api.pushover.net/1/messages.json

exit 0
