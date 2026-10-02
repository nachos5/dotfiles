#!/usr/bin/env bash

set -euo pipefail

notes_dir="$HOME/github/notes"
cd -- "$notes_dir"

# Closing the terminal detaches from tmux; the agent keeps running.
# If the session ended (or after a reboot), resume the latest notes conversation.
exec tmux new-session -A -s agent-notes -c "$notes_dir" \
    "$(command -v codex)" resume --last -c check_for_update_on_startup=false
