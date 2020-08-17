#!/bin/bash

# BUG: No real time clock on raspi
DATE=$(date +"%FT%H%MZ")

### Convert h264 to mp4 ###
ffmpeg -i "/home/pi/Documents/videos/video.h264" -c:v copy -f mp4 "/home/pi/Documents/videos/video.mp4"

# ### Cleanup h264 file ###
mv /home/pi/Documents/videos/video.h264 /tmp/video.h264

# ### Start recording.. ###
python /home/pi/Documents/videos/record.py