#!/bin/bash

touchpad_line=$(xinput list | grep Touchpad)
touchpad_id=$(echo "$touchpad_line" | awk '{for (i=3; i<=NF; i++) if (index($i, "id=") == 1) {print $i}; }' | awk -F= '{print $2}')
touchpad_name=$(xinput list-props "$touchpad_id" | grep "Device" | awk -F"'" '{print $2}')

xinput set-prop "$touchpad_name" "libinput Tapping Enabled" 1
xinput set-prop "$touchpad_name" "libinput Natural Scrolling Enabled" 1
