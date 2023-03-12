#!/bin/bash

tmux new-session -d -s dotfiles
tmux rename-window -t dotfiles:0 'dotfiles'
tmux send-keys -t dotfiles:0 "cd \"${HOME}/github/dotfiles\" && nvim" C-m
wezterm start -- tmux a -t dotfiles
