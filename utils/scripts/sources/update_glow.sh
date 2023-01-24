#!/bin/bash

# https://github.com/charmbracelet/glow#build-requires-go-113

cd ~/github/sources/glow
git pull
go build
cd ~/bin
ln -sf ~/github/sources/glow/glow .
