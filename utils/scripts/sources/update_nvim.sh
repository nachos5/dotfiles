#!/bin/bash

# https://github.com/neovim/neovim/wiki/Building-Neovim

sudo apt-get install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen
cd ~/github/sources/neovim || exit
git pull
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
