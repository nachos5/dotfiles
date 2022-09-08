#!/bin/bash

/usr/bin/jackd -dalsa -dhw:0 -r44100 -p1008 -n2 -S &>/dev/null &
pactl load-module module-jack-sink
pactl load-module module-jack-source channels=2 connect=0
pacmd set-default-sink jack_out
