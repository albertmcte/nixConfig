dirTemp=/home/wash/linuxbin/tmpOneDrivePhotos
dirSorted=/home/wash/linuxbin/tmpPhotos

rclone -v copy onedrive:Pictures/Samsung\ Gallery/ "$dirTemp"
ra=$?

if [ "$ra" != "0" ] ; then /home/wash/linuxbin/pushover.sh 'S25 Onedrive to Anubis' 'FAILED' > /dev/null 2>&1 && exit 99; fi

find "$dirTemp" -type f -exec cp -np {} "$dirSorted" \;

for file in "$dirSorted"/*
do
        if [[ "$file" =~ .*mp4$ ]] || [[ "$file" =~ .*mov$ ]] || [[ "$file" =~ .*gif$ ]]; then
                 mkdir -p /mercury/homevids/"$(date +"%Y" -r "$file")"/"$(date +"%m" -r "$file")" && cp -np "$file" /mercury/homevids/"$(date +"%Y" -r "$file")"/"$(date +"%m" -r "$file")"
        elif [[ "$file" =~ .*jpg$ ]] || [[ "$file" =~ .*png$ ]] || [[ "$file" =~ .*dng$ ]] || [[ "$file" =~ .*heic$ ]]; then
                 mkdir -p /mercury/photos/"$(date +"%Y" -r "$file")"/"$(date +"%m" -r "$file")" && cp -np "$file" /mercury/photos/"$(date +"%Y" -r "$file")"/"$(date +"%m" -r "$file")"
        fi
done

echo "pics grabbed at $(date)" >> /home/wash/OneDriveCanary.txt

/home/wash/linuxbin/pushover.sh 'S25 Onedrive to Anubis' 'SUCCESS' > /dev/null 2>&1

rclone -v copy /mercury/music onedrive:/Music
rb=$?

if [ "$rb" != "0" ] ; then /home/wash/linuxbin/pushover.sh 'Anubis Music to OneDrive' 'FAILED' > /dev/null 2>&1 && exit 99; fi

echo "Music synced at $(date)" >> /home/wash/OneDriveCanary.txt

exit 0
