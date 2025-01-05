#!/bin/bash

/usr/bin/jackd -dalsa -dhw:0 -r44100 -p4032 -n2 -S &> /dev/null &
pactl load-module module-jack-sink
pactl load-module module-jack-source channels=2 connect=0
pacmd set-default-sink jack_out

# /etc/pulse/default.pa
# load-module module-jack-sink
# load-module module-jack-source
