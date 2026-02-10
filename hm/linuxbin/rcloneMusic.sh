/run/current-system/sw/bin/rclone -v copy /mercury/music onedrive:/Music

ra=$?

if [ "$ra" != "0" ] ; then /home/wash/linuxbin/pushover.sh 'Anubis Music to OneDrive' 'FAILED' > /dev/null 2>&1 && exit 99; fi


echo "completed at $(date)" >> /home/wash/OneDriveCanary.txt
exit 0
