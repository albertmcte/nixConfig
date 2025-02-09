
[[ "$2" != "" ]] && curl -s -F "token="$(cat ${config.age.secrets.pushover_token.path}) -F "user="$(cat ${config.age.secrets.pushover_user.path}) -F "title=$1" -F "message=$2" https://api.pushover.net/1/messages.json

exit 0
