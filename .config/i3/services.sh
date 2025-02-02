#!/bin/bash

killall -q ibus-daemon
killall -q at-spi-bus-launcher
killall -q gnome-keyring-daemon

ulimit -n 65535
