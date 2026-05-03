#!/bin/bash

# Start by running some custom clean aliases.
shopt -s expand_aliases
source "/home/gulli/.bash_aliases"
dockerstop
dockerprune
lsp_log_clear
null_ls_log_clear
remove_nvim_swaps

# Clean thumbnail cache
rm -rf /home/gulli/.cache/thumbnails/* /home/gulli/.thumbnails/*

# Clean Trash
rm -rf /home/gulli/.local/share/Trash/*

# Clean system logs
journalctl --vacuum-time=3d

# Clean package cache
# Run to see how big the cache is: du -sh /var/cache/apt/archives
apt autoclean -y
apt clean -y

# Clean package manager / tool caches (all safely regenerable)
rm -rf ~/.cache/pre-commit
rm -rf ~/.cache/pip ~/.cache/uv
rm -rf ~/.cache/yarn ~/.cache/typescript
rm -rf ~/.bun/install/cache
command -v npm > /dev/null && npm cache clean --force > /dev/null 2>&1
command -v go > /dev/null && go clean -cache > /dev/null 2>&1

# Clean firefox
rm -rf ~/.cache/mozilla/firefox/*
rm -rf ~/.var/app/org.mozilla.firefox/cache/*

# Remove unnecessary packages
apt autoremove -y

# Update and upgrade packages
echo "UPDATE..."
apt update -y
echo "UPGRADE..."
apt upgrade -y
# apt full-upgrade -y

# Update GRUB
update-grub
