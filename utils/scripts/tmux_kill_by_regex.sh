#!/bin/bash

pattern="$1"

# Get the list of available sessions and their names
sessions=$(tmux list-sessions -F '#{session_name}')

# Filter sessions by the regex pattern
filtered_sessions=$(echo "$sessions" | grep -E "$pattern")

# Kill the filtered sessions
for session_name in $filtered_sessions; do
    tmux kill-session -t "$session_name"
done
