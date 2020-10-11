// var ffmpeg = require("fluent-ffmpeg");
// var inFilename = "04bae2c2-65a4-4c25-89d3-c9c6ab392e93.h264";
// var outFilename = "video.mp4";

// ffmpeg(inFilename)
//   .outputOptions("-c:v", "copy")
//   .save(outFilename);

var ffmpeg = require("fluent-ffmpeg");
var fs = require('fs')