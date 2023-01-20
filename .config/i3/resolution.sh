#!/bin/bash

source "$HOME/.bashrc"

resolution="1920x1080"

if [ -v INITIAL_RESOLUTION ]; then
  resolution=$INITIAL_RESOLUTION
fi

exec xrandr --output eDP-1 --mode "$resolution"
