#!/bin/bash

tmux new-session -d -s term
tmux rename-window -t term:0 'term'

wezterm start -- tmux a -t term
