#!/usr/bin/env bash
# Wrapper for xdg-desktop-portal-termfilechooser that opens xplr in wezterm.
# Called by the portal as:
#   filechooser_xplr.sh <multiple> <directory> <save> <suggested_path> <out_file>
#   $1 multiple  (0/1) select multiple files — unused, xplr multi-select works either way
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
    # Navigate into the target folder, press Enter there to pick it, then
    # confirm/rename the filename.
    # shellcheck disable=SC2086,SC2016 # word-split termcmd; inner $1.. expand in the child shell
    $termcmd bash -c '
        dir="$(xplr --print-pwd-as-result "$1")"
        [ -n "$dir" ] || exit 0
        read -r -e -p "Save as: " -i "$2" name
        [ -n "$name" ] || name="$2"
        printf "%s/%s\n" "${dir%/}" "$name" > "$3"
    ' bash "$start_dir" "$filename" "$out"
elif [ "$directory" = "1" ]; then
    start_dir="$path"
    [ -d "$start_dir" ] || start_dir="$HOME"
    # Navigate into the target folder and press Enter there to select it.
    # shellcheck disable=SC2086,SC2016 # word-split termcmd; inner $1.. expand in the child shell
    $termcmd bash -c 'xplr --print-pwd-as-result "$1" > "$2"' bash "$start_dir" "$out"
else
    start_dir="$path"
    [ -d "$start_dir" ] || start_dir="$HOME"
    # xplr prints the selection (or the focused file) on quit-with-result.
    # Like the GTK dialog, Enter on a folder enters it (reopen xplr inside)
    # instead of returning it — Firefox can't handle a directory result.
    # shellcheck disable=SC2086,SC2016 # word-split termcmd; inner $1.. expand in the child shell
    $termcmd bash -c '
        dir="$1"
        while :; do
            sel="$(xplr "$dir")"
            [ -n "$sel" ] || exit 0
            first="$(printf "%s" "$sel" | head -n 1)"
            if [ -d "$first" ]; then
                dir="$first"
                continue
            fi
            printf "%s\n" "$sel" > "$2"
            exit 0
        done
    ' bash "$start_dir" "$out"
fi
