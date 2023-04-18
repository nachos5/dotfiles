#!/bin/bash

current_session=$(tmux display-message -p "#{session_name}")
sessions=$(tmux list-sessions -F "#{session_created} #{session_name}" | sort -n | cut -d ' ' -f 2- | nl -v 0 -s ': ' -w 1 -n ln | awk -v curr="$current_session" '{ if ($2 == curr) printf("#"); print }' | awk -v ORS=' | ' '1' | head -c -3)

echo "$sessions"
