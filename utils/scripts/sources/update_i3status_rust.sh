#!/bin/bash

# https://github.com/greshake/i3status-rust/blob/master/doc/dev.md

rustup update
cd ~/github/sources/i3status-rust
git pull
cargo install --path . --locked
./install.sh
