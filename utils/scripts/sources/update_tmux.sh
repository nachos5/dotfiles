#!/bin/bash

# https://github.com/tmux/tmux#from-version-control

cd ~/github/sources/tmux
git pull
sh autogen.sh
./configure && make

cd ~/bin
ln -sf ~/github/sources/tmux/tmux .
