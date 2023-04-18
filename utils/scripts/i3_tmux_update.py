#!/usr/bin/env python3

import i3ipc
import subprocess
from time import sleep
import psutil

def get_focused_tty(focused_pid):
    try:
        process = psutil.Process(focused_pid)
        return process.terminal()
    except (psutil.NoSuchProcess, psutil.AccessDenied):
        return None

def update_tmux_status_bar(connection:i3ipc.Connection, event:i3ipc.events.IpcBaseEvent):
    pass

i3 = i3ipc.Connection()

# Subscribe to window focus and workspace events
i3.on("window::focus", update_tmux_status_bar)
# i3.on("workspace::focus", update_tmux_status_bar)

# Start the event loop
i3.main()
