#!/bin/bash

# https://wezfurlong.org/wezterm/install/source.html#installing-from-source

cd ~/github/sources/wezterm || exit
git pull
./get-deps
cargo build --release
cargo run --release --bin wezterm -- start

cd ~/bin || exit
ln -sf ~/github/sources/wezterm/target/release/wezterm .
