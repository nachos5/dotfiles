#!/bin/bash

# Apply this computer's saved display layout before opening applications.
i3_dir=$(dirname -- "$(readlink -f -- "${BASH_SOURCE[0]}")")
computer_id=${MY_COMPUTER_ID:-}
display_startup_script=""
case "$computer_id" in
"" | [!a-zA-Z0-9]* | *[!a-zA-Z0-9_.-]*) ;;
*)
    if [ "${#computer_id}" -le 128 ] && [ -f "$i3_dir/display_startup/$computer_id.sh" ]; then
        display_startup_script="$i3_dir/display_startup/$computer_id.sh"
    fi
    ;;
esac

if [ -n "$display_startup_script" ]; then
    bash "$display_startup_script" || printf 'Display startup failed: %s\n' "$display_startup_script" >&2
fi

i3-msg 'workspace 1; exec --no-startup-id ~/utils/scripts/tmux_dotfiles.sh'
sleep 3
i3-msg 'workspace 2; exec --no-startup-id firefox'
sleep 3
i3-msg 'workspace 3; exec --no-startup-id firefox'
sleep 3
i3-msg 'workspace 4; exec --no-startup-id ~/utils/scripts/tmux_term.sh'
# sleep 3
# i3-msg 'workspace 7; exec --no-startup-id spotify'
# sleep 4
sleep 3
i3-msg 'workspace 1; exec --no-startup-id copyq'
i3-msg 'workspace 1; exec --no-startup-id emote'

# Run local i3 startup script if it exists.
if [ -x "$HOME/.config/i3_start_local.sh" ]; then
    "$HOME/.config/i3_start_local.sh"
fi
