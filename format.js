var ffmpeg = require("fluent-ffmpeg");
var fs = require('fs');

const myArgs = process.argv.slice(2);

try {
  ffmpeg(myArgs[0]).outputOptions("-c:v", "copy").save(myArgs[0].substring(0, myArgs[0].length - 5) + '.mp4');
  fs.appendFileSync('/home/pi/Documents/videos/log.txt', 'Formatted File:  ' + myArgs[0].substring(0, myArgs[0].length - 5) + '.mp4');
} catch (error) {
  fs.appendFileSync('/home/pi/Documents/videos/log.txt', 'ERROR! Could not format file')
  return;
}