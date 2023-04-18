#!/bin/bash

index=$1

# Check if index is an integer
if ! [[ $index =~ ^[0-9]+$ ]]; then
	echo "Error: index must be a non-negative integer."
	exit 1
fi

# Get total number of sessions
total_sessions=$(tmux list-sessions | wc -l)

# Check if index is within the range of total sessions
if ((index >= total_sessions || index < 0)); then
	echo "Error: index is out of range."
	exit 1
fi

# Adjust index to start from 1 for head command
index=$((index + 1))

session_name=$(tmux list-sessions -F "#{session_created} #{session_name}" | sort -n | head -n "$index" | tail -n 1 | cut -d ' ' -f 2-)

tmux switch-client -t "$session_name"

# Refresh the status bar
tmux refresh-client
