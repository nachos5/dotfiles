#!/bin/bash

# https://github.com/tmux/tmux#from-version-control

cd ~/github/sources/tmux || exit
git pull
sh autogen.sh
./configure && make

cd ~/bin || exit
ln -sf ~/github/sources/tmux/tmux .
