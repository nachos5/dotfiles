#!/bin/bash

# Get the name of the control to adjust from the command line argument
control=$1

# Get the current volume level of the specified control
volume=$(amixer -M get "$control" | awk '/%/ {print $4}' | tr -d '[]%')

# Adjust the volume level up or down by 5%, based on the second command line argument
case "$2" in
"up")
    new_volume=$((volume + 5))
    ;;
"down")
    new_volume=$((volume - 5))
    ;;
*)
    echo "Invalid argument: $2. Usage: $0 <control> {up|down}"
    exit 1
    ;;
esac

# Set the new volume level for the specified control
amixer -M -q set "$control" "$new_volume"%
