#!/bin/bash
# Saved by toolbox. Run directly or from i3/start.sh.
# Missing required displays leave the current layout unchanged.
set -eu
export LC_ALL=C

outputs=$(xrandr --query)
connected=$(printf '%s\n' "$outputs" | awk '$2 == "connected" { print $1 }')
available=$(printf '%s\n' "$outputs" | awk '$2 == "connected" || $2 == "disconnected" { print $1 }')

for output in DisplayPort-0 HDMI-A-0; do
    if ! printf '%s\n' "$connected" | grep -Fxq -- "$output"; then
        printf 'Saved display %s is not connected; keeping current layout.\n' "$output" >&2
        exit 1
    fi
done

set -- --fb 4480x1500
set -- "$@" --output DisplayPort-0 --mode 2560x1440 --pos 1920x0 --rotate normal --reflect normal --transform none --panning 0x0 --rate 59.95 --primary
if printf '%s\n' "$available" | grep -Fxq -- DisplayPort-1; then
    set -- "$@" --output DisplayPort-1 --off
fi
if printf '%s\n' "$available" | grep -Fxq -- DisplayPort-2; then
    set -- "$@" --output DisplayPort-2 --off
fi
set -- "$@" --output HDMI-A-0 --mode 1920x1080 --pos 0x420 --rotate normal --reflect normal --transform none --panning 0x0 --rate 60.00

xrandr --dryrun "$@"
exec xrandr "$@"
