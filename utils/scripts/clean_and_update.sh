#!/bin/bash

# clean thumbnail cache
rm -v -f ~/.cache/thumbnails/*/*.png ~/.thumbnails/*/*.png
rm -v -f ~/.cache/thumbnails/*/*/*.png ~/.thumbnails/*/*/*.png

apt-get update -y
apt-get autoclean -y
apt-get clean -y
apt-get autoremove -y
