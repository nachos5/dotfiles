#!/bin/bash

tr < /dev/urandom -dc 'a-zA-Z0-9' | fold -w "$1" | head -n 1
