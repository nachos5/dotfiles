#!/bin/bash

# This script fixed a super annoying lag issue I was dealing with.

killall -q ibus-daemon
killall -q at-spi-bus-launcher
# Killing the keyring daemon caused a keyring password prompt on every login,
# since it discarded the PAM-unlocked instance.
# killall -q gnome-keyring-daemon

ulimit -n 65535
