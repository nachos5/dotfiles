#!/bin/bash

# Restarts the PipeWire audio stack when sound dies.
#
# The usual failure mode is WirePlumber dropping the sound card: the kernel
# still lists it in `aplay -l`, but `pactl list short cards` is empty and the
# only sink left is the `auto_null` dummy, so everything plays into the void.
# Restarting the session manager is almost always enough, so escalate in steps
# instead of bouncing the whole stack every time.

notify() {
    echo "$*"
    command -v notify-send > /dev/null && timeout -k 1 2 notify-send -a "audio_restart" -t 4000 "Audio" "$*"
}

# Repeated shortcut presses must not restart services underneath each other.
exec 9> "${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/audio_restart.lock"
if ! flock -n 9; then
    notify "An audio restart is already in progress."
    exit 0
fi

# A wedged server can leave pactl waiting far longer than our polling window.
pactl() {
    timeout -k 1 2 pactl "$@"
}

# Number of real (non-dummy) sinks PipeWire is exposing.
real_sinks() {
    local sinks
    sinks=$(pactl list short sinks 2> /dev/null) || return 1
    printf '%s\n' "$sinks" | awk 'NF && $2 != "auto_null" { count++ } END { print count+0 }'
}

# Allow ~8s for discovery, but escalate immediately if the server stops replying.
wait_for_sink() {
    local count
    for _ in $(seq 1 16); do
        count=$(real_sinks) || return 1
        [ "$count" -gt 0 ] && return 0
        sleep 0.5
    done
    return 1
}

# 1. Session manager only. This is what usually does it.
echo "Restarting wireplumber..."
systemctl --user restart wireplumber

if ! wait_for_sink; then
    # 2. Full stack.
    echo "No sink yet; restarting the full PipeWire stack..."
    systemctl --user restart pipewire pipewire-pulse wireplumber

    if ! wait_for_sink; then
        # 3. Sockets too, in case activation itself is wedged.
        echo "Still nothing; restarting sockets..."
        systemctl --user restart pipewire.socket pipewire-pulse.socket
        systemctl --user restart pipewire pipewire-pulse wireplumber

        if ! wait_for_sink; then
            notify "Restart failed - no output came back. Check 'aplay -l' and 'journalctl -k -b' for missing cards or USB disconnects."
            exit 1
        fi
    fi
fi

# Pick a sink to make default. Prefer real speakers/headphones over HDMI, which
# is what PipeWire tends to land on by itself after the card is re-added.
sink=$(pactl list sinks 2> /dev/null | awk '
    /^Sink #/            { name=""; port="" }
    /^\tName:/           { name=$2 }
    /^\tActive Port:/    { port=$0; sub(/^\tActive Port: /, "", port); print name "\t" port }
' | grep -viE '\bHDMI|auto_null' | head -1 | cut -f1)

# Fall back to any real sink if the port heuristic found nothing.
[ -z "$sink" ] && sink=$(pactl list short sinks | grep -v 'auto_null' | head -1 | awk '{print $2}')

if [ -n "$sink" ]; then
    pactl set-default-sink "$sink"
    pactl set-sink-mute "$sink" 0

    # Drag any streams still pointing at the old/dummy sink over to the new one.
    pactl list short sink-inputs 2> /dev/null | awk '{print $1}' | while read -r id; do
        pactl move-sink-input "$id" "$sink" 2> /dev/null
    done
fi

desc=$(pactl list sinks | grep -A2 "Name: $sink" | awk -F': ' '/Description:/ {print $2}')
vol=$(pactl get-sink-volume @DEFAULT_SINK@ 2> /dev/null | awk 'NR==1 {print $5}')
notify "Restarted. Output: ${desc:-$sink} (${vol:-?})"
