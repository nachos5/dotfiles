#!/bin/bash

# https://github.com/neovim/neovim/blob/master/INSTALL.md#install-from-source
# https://github.com/neovim/neovim/blob/master/BUILD.md

# Required dependencies.
sudo apt-get install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen build-essential

# Update/pull from source.
cd ~/github/sources/neovim || exit
git pull

# Clear the CMake cache.
sudo rm -r ./build
sudo rm -r ./.deps

# Build.
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
