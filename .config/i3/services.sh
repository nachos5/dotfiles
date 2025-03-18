#!/bin/bash

# This script fixed a super annoying lag issue I was dealing with.

killall -q ibus-daemon
killall -q at-spi-bus-launcher
killall -q gnome-keyring-daemon

ulimit -n 65535
