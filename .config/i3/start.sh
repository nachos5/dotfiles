#!/bin/bash

i3-msg 'workspace 1; exec --no-startup-id ~/utils/scripts/tmux-dotfiles.sh';
sleep 3;
i3-msg 'workspace 2; exec --no-startup-id firefox';
sleep 3;
i3-msg 'workspace 3; exec --no-startup-id firefox';
sleep 3;
i3-msg 'workspace 4; exec --no-startup-id wezterm; fullscreen enable'
sleep 3;
i3-msg 'workspace 7; exec --no-startup-id spotify';
sleep 3;
i3-msg 'workspace 1; exec --no-startup-id copyq';
