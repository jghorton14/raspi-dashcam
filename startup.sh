#!/bin/bash

DATE=$(date +"%FT%H%MZ")
LEXARMOUNTPATH=$(findmnt -nr -o target -S /dev/sda1)
UUID=$(cat /proc/sys/kernel/random/uuid)
LOGPATH=/home/pi/Documents/videos/log.txt

### Log ###
echo "--------------" >> $LOGPATH
echo $DATE >> $LOGPATH
echo $UUID >> $LOGPATH

### Move previous recording and rename file to USB ###
mv /home/pi/Documents/videos/video.h264 $LEXARMOUNTPATH/
cd $LEXARMOUNTPATH
mv video.h264 $UUID.h264

# ### Start recording.. ###
python /home/pi/Documents/videos/record.py
