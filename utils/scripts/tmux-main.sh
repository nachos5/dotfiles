#!/bin/bash

tmux new-session -d -s main
tmux rename-window -t main:0 'dotfiles'
tmux send-keys -t main:0 'cd "${HOME}/github/dotfiles" && nvim' C-m
wezterm start -- tmux a -t main
