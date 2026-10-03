#!/usr/bin/env bash
# Link the versioned Firefox customizations into an explicitly chosen profile.
set -euo pipefail

if [ "$#" -ne 1 ] || [ ! -f "$1/prefs.js" ]; then
    echo "Usage: bash $0 /path/to/firefox/profile" >&2
    echo "Find the Profile Directory in Firefox's about:support page." >&2
    exit 1
fi

DOTFILES="$(dirname "$(dirname "$(dirname "$(realpath "${BASH_SOURCE[0]}")")")")"
PROFILE="$(realpath "$1")"

mkdir -p "$PROFILE/chrome"
for file in user.js chrome/userChrome.css; do
    source_path="$DOTFILES/.config/firefox/$file"
    target_path="$PROFILE/$file"
    if [ -L "$target_path" ] && [ "$(readlink "$target_path")" = "$source_path" ]; then
        continue
    fi
    if [ -e "$target_path" ] || [ -L "$target_path" ]; then
        mv --backup=numbered -- "$target_path" "$target_path.pre-dotfiles"
        echo "Backed up $target_path to $target_path.pre-dotfiles"
    fi
    ln -s -- "$source_path" "$target_path"
done

echo "Firefox customizations linked into $PROFILE."
echo "Fully quit and restart Firefox to apply them."
