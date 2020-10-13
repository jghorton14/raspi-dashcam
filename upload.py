#!/usr/bin/python

import boto3
import os
import sys
from botocore.exceptions import ClientError

filename    = sys.argv[1]
bucket      = sys.argv[2]
objectname  = sys.argv[3]

with open("/home/pi/Documents/videos/log.txt", "a") as myfile:
  myfile.write("Attempting to upload to s3.." + "\n")

# Upload the file
s3_client = boto3.client('s3')
try:
  response = s3_client.upload_file(filename, bucket, objectname)
  os.remove(filename)
  with open("/home/pi/Documents/videos/log.txt", "a") as myfile:
    myfile.write("uploaded file and deleted file" + "\n") 
except ClientError as e:
  with open("/home/pi/Documents/videos/log.txt", "a") as myfile:
    myfile.write("failed to upload S3" + "\n")
