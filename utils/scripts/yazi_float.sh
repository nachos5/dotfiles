#!/usr/bin/env bash

set -euo pipefail

choice_file="$(mktemp -t "yazi-float.XXXXXX")"
trap 'rm -f -- "$choice_file"' EXIT

state_dir="${XDG_STATE_HOME:-$HOME/.local/state}/yazi"
cwd_file="$state_dir/float-cwd"
start_dir="$HOME"

mkdir -p -- "$state_dir"
if [ -s "$cwd_file" ]; then
    saved_dir="$(< "$cwd_file")"
    if [ -d "$saved_dir" ]; then
        start_dir="$saved_dir"
    fi
fi

# Chooser mode enters directories as usual, but exits after opening a file.
# The cwd file makes the next float resume in the directory where this one closed.
yazi "$start_dir" --chooser-file="$choice_file" --cwd-file="$cwd_file"

while IFS= read -r file || [ -n "$file" ]; do
    [ -n "$file" ] || continue
    setsid --fork xdg-open "$file" > /dev/null 2>&1
done < "$choice_file"
