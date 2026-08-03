#!/bin/bash

# https://github.com/junegunn/fzf#using-git

sudo apt remove fzf
cd ~/github/sources/fzf || exit
git pull
./install
