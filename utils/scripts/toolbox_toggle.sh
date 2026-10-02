#!/usr/bin/env bash

set -euo pipefail

# i3 launches this without the PATH additions from the interactive shell.
export PATH="$PATH:$HOME/go/bin:/usr/local/go/bin"

exec "$HOME/utils/scripts/float_toggle.sh" toolbox-float "$HOME/go/bin/toolbox"
