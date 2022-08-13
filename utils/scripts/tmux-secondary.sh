#!/bin/bash

tmux new-session -d -s secondary
wezterm start -- tmux a -t secondary
