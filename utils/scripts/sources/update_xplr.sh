#!/bin/bash

# https://xplr.dev/en/install#build-from-source

cd ~/github/sources/xplr
git pull
# build
cargo build --locked --release --bin xplr
# place in $PATH
sudo cp target/release/xplr /usr/local/bin/

cd ~/bin
ln -sf ~/github/sources/xplr/target/release/xplr .
