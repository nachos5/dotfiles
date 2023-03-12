#!/bin/bash

# https://github.com/charmbracelet/glow#build-requires-go-113

cd ~/github/sources/glow || exit
git pull
go build
cd ~/bin || exit
ln -sf ~/github/sources/glow/glow .
