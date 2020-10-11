#!/bin/bash

DATE=$(date +"%FT%H%MZ")
LEXARMOUNTPATH=$(findmnt -nr -o target -S /dev/sda1)
UUID=$(cat /proc/sys/kernel/random/uuid)
LOGPATH=/home/pi/Documents/videos/log.txt

### Log ###
echo "--------------" >> $LOGPATH
echo $DATE >> $LOGPATH
echo $UUID >> $LOGPATH

wget -q --spider http://google.com
if [ $? -eq 0 ]; then
  ### Online ###
  echo "Attempting to save to s3" >> $LOGPATH

  ### Transfer all videos to S3 ###

  ### Delete Videos from USB ###
else
  ### Offline ###
  echo "Saving to USB" >> $LOGPATH

  ### Move previous recording and rename file to USB ###
  mv /home/pi/Documents/videos/video.h264 $LEXARMOUNTPATH/
  cd $LEXARMOUNTPATH
  mv video.h264 $UUID.h264
fi

echo "Finished"

# ### Start recording.. ###
# python /home/pi/Documents/videos/record.py
