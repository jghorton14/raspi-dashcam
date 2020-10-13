#!/bin/bash

DATE=$(date +"%FT%H%MZ")
LEXARMOUNTPATH=$(findmnt -nr -o target -S /dev/sda1)
UUID=$(cat /proc/sys/kernel/random/uuid)
LOGPATH=/home/pi/Documents/videos/log.txt

echo "--------------" >>$LOGPATH
echo $DATE >>$LOGPATH
echo $UUID >>$LOGPATH

### Move previous file, convert h264 to mp4, more to  ### 
moveAndFormath264() {
  ### Move previous recording and rename file to USB ###
  mv /home/pi/Documents/videos/video.h264 $LEXARMOUNTPATH/original/
  mv $LEXARMOUNTPATH/original/video.h264 $LEXARMOUNTPATH/original/$UUID.h264

  ## Format to mp4 ###
  cd $LEXARMOUNTPATH/original/
  echo "Attempting to convert h264 to mp4" >>$LOGPATH
  node /home/pi/Documents/videos/format.js $UUID.h264

  ### Move formatted file into usb area ###
  mv $LEXARMOUNTPATH/original/$UUID.mp4 $LEXARMOUNTPATH/formatted/
}

### Transfer all original videos from usb to S3 ###
fileS3Original() {
  cd $LEXARMOUNTPATH/original/
  echo "uploading original h264 files" >>$LOGPATH

  for filename in *.h264; do
    echo $filename >>$LOGPATH
    python /home/pi/Documents/videos/upload.py $filename raspi-dashcam original/$filename
  done
}

### Transfer all formatted videos from usb to S3 ###
fileS3Format() {
  cd $LEXARMOUNTPATH/formatted/
  echo "uploading formatted mp4 files" >>$LOGPATH

  for filename in *.mp4; do
    echo $filename >>$LOGPATH
    python /home/pi/Documents/videos/upload.py $filename raspi-dashcam formatted/$filename
  done
}

if [[ -f /home/pi/Documents/videos/video.h264 ]]; then
  echo "video.h264 file exists" >>$LOGPATH
  moveAndFormath264
else
  echo "video.h264 file does not exists." >>$LOGPATH
fi

wget -q --spider http://google.com
if [ $? -eq 0 ]; then
  ### Online ###
  echo "Attempting to save to s3" >>$LOGPATH

  fileS3Original
  fileS3Format
  ### Delete Videos from USB ###
else
  ### Offline ###
  echo "Did not upload to s3" >>$LOGPATH
fi

### Start recording.. ###
python /home/pi/Documents/videos/record.py
