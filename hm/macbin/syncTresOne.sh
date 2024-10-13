#!/bin/bash
rsync -av --delete /Users/wash/Alpha/ /Users/wash/OneDrive/
ra=$?
if [ "$ra" != "0" ] ; then /Users/wash/bin/pushover.sh 'Tresorit -> OneDrive Sync' 'FAILED' > /dev/null 2>&1 && exit 99; fi
