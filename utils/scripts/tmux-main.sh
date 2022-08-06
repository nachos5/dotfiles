#!/bin/bash

tmux kill-server
tmux new-session -d -s main
tmux rename-window -t main:0 'dotfiles'
tmux send-keys -t main:0 'cd "${HOME}/github/dotfiles" && nvim' C-m
gnome-terminal -- tmux a -t main
