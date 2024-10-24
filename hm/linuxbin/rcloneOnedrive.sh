#!/usr/bin/env nix-shell
#!nix-shell -i zsh -p zsh rclone

dirTemp=/home/wash/linuxbin/tmpOneDrivePhotos
dirSorted=/home/wash/linuxbin/tmpPhotos
/usr/bin/rclone -v copy onedrive:Pictures/Samsung\ Gallery/ "$dirTemp"
ra=$?

if [ "$ra" != "0" ] ; then /home/wash/linuxbin/pushover.sh 'S24 Onedrive to Anubis' 'FAILED' > /dev/null 2>&1 && exit 99; fi

cp -np "$dirTemp"/**/*(.D) "$dirSorted"

for file in "$dirSorted"/*
do
        if [[ "$file" =~ .*mp4$ ]] || [[ "$file" =~ .*mov$ ]] || [[ "$file" =~ .*gif$ ]]; then
                 mkdir -p /mercury/homevids/$(date +"%Y" -r $file)/$(date +"%m" -r $file) && cp -np "$file" /mercury/homevids/$(date +"%Y" -r $file)/$(date +"%m" -r $file)
        elif [[ "$file" =~ .*jpg$ ]] || [[ "$file" =~ .*png$ ]] || [[ "$file" =~ .*dng$ ]] || [[ "$file" =~ .*heic$ ]]; then
                 mkdir -p /mercury/photos/$(date +"%Y" -r $file)/$(date +"%m" -r $file) && cp -np "$file" /mercury/photos/$(date +"%Y" -r $file)/$(date +"%m" -r $file)
        fi
done
/home/wash/linuxbin/pushover.sh 'S24 Onedrive to Anubis' 'SUCCESS' > /dev/null 2>&1
echo "completed at $(date)" >> /home/wash/OneDriveCanary.txt
exit $?
