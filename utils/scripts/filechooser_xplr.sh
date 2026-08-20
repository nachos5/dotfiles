#!/usr/bin/env bash
# Wrapper for xdg-desktop-portal-termfilechooser that opens yazi in wezterm.
# (Filename kept from the xplr era to avoid re-wiring the portal config.)
# Called by the portal as:
#   filechooser_xplr.sh <multiple> <directory> <save> <suggested_path> <out_file>
#   $1 multiple  (0/1) select multiple files — unused, yazi multi-select works either way
#   $2 directory (0/1) select a directory instead of a file
#   $3 save      (0/1) save mode (suggested_path holds the proposed filename)
#   $4 suggested path
#   $5 file to write the selected path(s) to
set -euo pipefail

# The portal runs as a systemd user service, so ~/bin is not on PATH.
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

directory="${2:-0}"
save="${3:-0}"
path="${4:-}"
out="${5:?output file required}"

termcmd="${TERMCMD:-wezterm start --always-new-process --}"

if [ "$save" = "1" ]; then
    start_dir="$(dirname "$path")"
    [ -d "$start_dir" ] || start_dir="$HOME/Downloads"
    filename="$(basename "$path")"
    # Navigate to the target folder (l/Right enters, Enter or q picks it,
    # Q cancels — see .config/yazi/portal/), then confirm/rename the filename.
    # shellcheck disable=SC2086,SC2016 # word-split termcmd; inner $1.. expand in the child shell
    $termcmd bash -c '
        tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
        YAZI_CONFIG_HOME="$HOME/.config/yazi/portal" yazi "$1" --cwd-file="$tmp"
        dir="$(cat "$tmp")"
        rm -f -- "$tmp"
        [ -n "$dir" ] || exit 0
        read -r -e -p "Save as: " -i "$2" name
        [ -n "$name" ] || name="$2"
        printf "%s/%s\n" "${dir%/}" "$name" > "$3"
    ' bash "$start_dir" "$filename" "$out"
elif [ "$directory" = "1" ]; then
    start_dir="$path"
    [ -d "$start_dir" ] || start_dir="$HOME"
    # Navigate to the target folder (l/Right enters, Enter or q picks it,
    # Q cancels — see .config/yazi/portal/).
    # shellcheck disable=SC2086,SC2016 # word-split termcmd; inner $1.. expand in the child shell
    $termcmd bash -c 'YAZI_CONFIG_HOME="$HOME/.config/yazi/portal" yazi "$1" --cwd-file="$2"' bash "$start_dir" "$out"
else
    start_dir="$path"
    [ -d "$start_dir" ] || start_dir="$HOME"
    # Enter on a file (or on a Space-selection) writes the path(s) and quits.
    # Enter on a folder just enters it, like the GTK dialog — yazi only
    # "returns" files in chooser mode, so no directory-result guard is needed.
    # shellcheck disable=SC2086,SC2016 # word-split termcmd; inner $1.. expand in the child shell
    $termcmd bash -c 'yazi "$1" --chooser-file="$2"' bash "$start_dir" "$out"
fi
