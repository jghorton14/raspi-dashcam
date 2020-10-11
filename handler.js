'use strict';

const AWS = require('aws-sdk');
var ffmpeg = require("fluent-ffmpeg");
var fs = require('fs')

// get reference to S3 client
const s3 = new AWS.S3();

/**
 * Convert h264 into mp4
 * @param {*} event 
 * @param {*} context 
 * @param {*} callback 
 */
module.exports.hello = async (event, context, callback) => {
  console.log('s3', event.Records[0].s3);

  // Read options from event param.
  const srcBucket = event.Records[0].s3.bucket.name;
  const srcKey = event.Records[0].s3.object.key.match(/original\/(.*)/)[1];
  const dstFolder = "/formatted/";
  const dstKey = srcKey.substring(0, srcKey.length - 5);

  // Download the image from the S3 source bucket. 
  try {
    const params = {
      Bucket: srcBucket,
      Key: event.Records[0].s3.object.key
    };
    var h264OriginalFile = await s3.getObject(params).promise();
  } catch (error) {
    console.log(error);
    return;
  }

  // Convert h264 to mp4
  try {
    ffmpeg(h264OriginalFile).outputOptions("-c:v", "copy").save(dstKey + ".mp4");
  } catch (error) {
    console.log(error);
    return;
  }

  // List all files in 
  try {
    fs.readdir('/tmp/', (err, files) => {
      files.forEach(file => {
        console.log(file);
      });
    });
  } catch (error) {
    console.log(error);
    return;
  }


  // Upload the formatted mp4 to the formatted folder
  // try {
  //   const destparams = {
  //     Bucket: srcBucket,
  //     Key: dstFolder + dstKey + ".mp4",
  //     Body: ,
  //     ContentType: "image"
  //   };
  //   const putResult = await s3.putObject(destparams).promise();
  // } catch (error) {
  //   console.log(error);
  //   return;
  // }

  // var inFilename = "04bae2c2-65a4-4c25-89d3-c9c6ab392e93.h264";
  // var outFilename = "video.mp4";
  // ffmpeg(inFilename)
  //   .outputOptions("-c:v", "copy")
  //   .save(outFilename);

  return {
    statusCode: 200,
    body: JSON.stringify(
      {
        message: 'Hello world',
        input: event,
      },
      null,
      2
    ),
  };
};
