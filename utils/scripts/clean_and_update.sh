#!/bin/bash

# Clean thumbnail cache
rm -rf ~/.cache/thumbnails/* ~/.thumbnails/*

# Clean Trash
rm -rf ~/.local/share/Trash/*

# Clean system logs
journalctl --vacuum-time=3d

# Clean package cache
# Run to see how big the cache is: du -sh /var/cache/apt/archives
apt-get autoclean -y
apt-get clean -y

# Remove unnecessary packages
apt-get autoremove -y

# Update and upgrade packages
apt-get update -y
apt-get upgrade -y
