# raspi-dashcam
Raspberry Pi dashcam that records .h264 to usb, upload to s3 bucket when wifi available

### Instructions
* npm i
* sudo pip install boto3
* crontab -e
```@reboot sleep 20s && /home/pi/Documents/videos/startup.sh```
