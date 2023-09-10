#!/bin/bash

# https://github.com/jarun/nnn/wiki/Usage#from-source

cd ~/github/sources/nnn || exit
sudo apt-get install pkg-config libncursesw5-dev libreadline-dev
git pull
sudo make strip install

# https://github.com/xyb3rt/sxiv
sudo apt install libimlib2-dev libx11-dev libxft-dev libfreetype6-dev libfontconfig1-dev libgif-dev libexif-dev
cd ~/github/sources/sxiv || exit
git pull
make
sudo make install
