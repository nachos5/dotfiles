#!/bin/bash

# Clean thumbnail cache
rm -rf ~/.cache/thumbnails/* ~/.thumbnails/*

# Clean Trash
rm -rf ~/.local/share/Trash/*

# Clean package cache
apt-get autoclean -y
apt-get clean -y

# Remove unnecessary packages
apt-get autoremove -y

# Update and upgrade packages
apt-get update -y
apt-get upgrade -y
