import picamera
import datetime as dt

with picamera.PiCamera() as camera:
    camera.resolution = (480, 360)
    camera.framerate = 24
    camera.start_preview()
    camera.annotate_text_size = 10
    ### TODO FIX offline time sync when not connected to internet ###
    # camera.annotate_background = picamera.Color('black')
    # camera.annotate_text = dt.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    camera.start_recording('/home/pi/Documents/videos/video.h264')
    start = dt.datetime.now()
    
    while True:
        # camera.annotate_text = dt.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
        camera.wait_recording(0.2)
    camera.stop_recording()