#!/bin/bash

jackd_pid=$(pgrep jackd)
kill -9 "$jackd_pid"
