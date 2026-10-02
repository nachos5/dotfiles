#!/usr/bin/env bash

set -euo pipefail

window_class="${1:?Usage: float_toggle.sh CLASS COMMAND [ARG...]}"
shift

# Ignore repeated presses while a new window is still starting.
exec 9> "${XDG_RUNTIME_DIR:-/tmp}/$window_class-toggle-$UID.lock"
flock -n 9 || exit 0

find_window() {
    i3-msg -t get_tree | jq -r --arg window_class "$window_class" '
        first(
            .. | objects | select(.type? == "workspace") |
            .name as $workspace |
            .. | objects | select(.window_properties?.class == $window_class) |
            [.id, $workspace] | @tsv
        ) // empty
    '
}

read -r window_id workspace <<< "$(find_window)"
if [[ -n "$window_id" ]]; then
    if [[ "$workspace" == "__i3_scratch" ]]; then
        i3-msg "[con_id=$window_id] scratchpad show" > /dev/null
    else
        i3-msg "[con_id=$window_id] move scratchpad" > /dev/null
    fi
    exit 0
fi

"$HOME/bin/wezterm" start --always-new-process --class "$window_class" -- "$@" 9>&- &

# Keep the launch lock until i3 sees the window (up to five seconds).
for ((attempt = 0; attempt < 50; attempt++)); do
    [[ -n "$(find_window)" ]] && exit 0
    sleep 0.1
done
