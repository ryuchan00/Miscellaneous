import picamera

import time
import RPi.GPIO as GPIO

PICTURE_WIDTH = 800

PICTURE_HEIGHT = 600

SAVEDIR = "/var/www/html/camera/pictures/"

INTAVAL = 600

SLEEPTIME = 5

SENSOR_PIN = 9

GPIO.cleanup()

GPIO.setmode(GPIO.BCM)
GPIO.setup(SENSOR_PIN, GPIO.IN)
cam = picamera.PiCamera()

cam.resolution = (PICTURE_WIDTH, PICTURE_HEIGHT)

st = time.time() - INTAVAL

while True:
    if (GPIO.input(SENSOR_PIN) == GPIO.HIGH) \
            and (st + INTAVAL < time.time()):
        st = time.time()
        filename = time.strftime("%Y%m%d%H%M%S") + ".jpg"
        save_file = SAVEDIR + filename
        cam.capture(save_file)
    time.sleep(SLEEPTIME)
