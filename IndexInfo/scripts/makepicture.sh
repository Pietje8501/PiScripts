#!/bin/bash
fswebcam -q --jpeg 85 -D 1 webcam.jpg
mv webcam.jpg /var/www
