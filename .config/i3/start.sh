#!/bin/bash

i3-msg 'workspace 1; exec --no-startup-id ~/utils/scripts/tmux_dotfiles.sh'
sleep 3
i3-msg 'workspace 2; exec --no-startup-id firefox'
sleep 3
i3-msg 'workspace 3; exec --no-startup-id firefox'
sleep 3
i3-msg 'workspace 4; exec --no-startup-id ~/utils/scripts/tmux_term.sh'
sleep 3
i3-msg 'workspace 7; exec --no-startup-id spotify'
sleep 4
i3-msg 'workspace 1; exec --no-startup-id copyq'
i3-msg 'workspace 1; exec --no-startup-id emote'

# Run local i3 startup script if it exists.
if [ -x "$HOME/.config/i3_start_local.sh" ]; then
    "$HOME/.config/i3_start_local.sh"
fi
