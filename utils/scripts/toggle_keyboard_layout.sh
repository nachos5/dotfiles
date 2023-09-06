#!/bin/bash
current_layout=$(setxkbmap -query | grep layout | awk '{print $2}')

if [ "$current_layout" == "is_custom" ]; then
	setxkbmap -layout us
elif [ "$current_layout" == "us" ]; then
	setxkbmap -layout is_custom
else
	echo "Error: unknown layout"
fi
