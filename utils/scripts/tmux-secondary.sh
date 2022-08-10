#!/bin/bash

tmux new-session -d -s secondary
gnome-terminal -- tmux a -t secondary
