#!/bin/bash

DATE=$(date +"%FT%H%MZ")
LEXARMOUNTPATH=$(findmnt -nr -o target -S /dev/sda1)

### Move and rename file ###
mv /home/pi/Documents/videos/video.mp4 $LEXARMOUNTPATH/$DATE.mp4