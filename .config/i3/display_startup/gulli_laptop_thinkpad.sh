#!/bin/bash
# Saved by toolbox. Run directly or from i3/start.sh.
# Missing required displays leave the current layout unchanged.
set -eu
export LC_ALL=C

outputs=$(xrandr --query)
connected=$(printf '%s\n' "$outputs" | awk '$2 == "connected" { print $1 }')
available=$(printf '%s\n' "$outputs" | awk '$2 == "connected" || $2 == "disconnected" { print $1 }')

for output in eDP-1; do
    if ! printf '%s\n' "$connected" | grep -Fxq -- "$output"; then
        printf 'Saved display %s is not connected; keeping current layout.\n' "$output" >&2
        exit 1
    fi
done

set -- --fb 1920x1200
set -- "$@" --output eDP-1 --mode 1920x1200 --pos 0x0 --rotate normal --reflect normal --transform none --panning 0x0 --rate 60.00 --primary
if printf '%s\n' "$available" | grep -Fxq -- HDMI-1; then
    set -- "$@" --output HDMI-1 --off
fi
if printf '%s\n' "$available" | grep -Fxq -- DP-1; then
    set -- "$@" --output DP-1 --off
fi
if printf '%s\n' "$available" | grep -Fxq -- DP-2; then
    set -- "$@" --output DP-2 --off
fi
if printf '%s\n' "$available" | grep -Fxq -- DP-3; then
    set -- "$@" --output DP-3 --off
fi
if printf '%s\n' "$available" | grep -Fxq -- DP-4; then
    set -- "$@" --output DP-4 --off
fi

xrandr --dryrun "$@"
exec xrandr "$@"
