#! /usr/bin/env python

import RPi.GPIO as GPIO
import time

GPIO.cleanup()

GPIO.setmode(GPIO.BCM)
GPIO.setup(4, GPIO.OUT)

while True:
    GPIO.output(4, GPIO.HIGH)

    time.sleep(1)

    GPIO.output(4, GPIO.LOW)
    time.sleep(1)
