#!/usr/bin/env bash
# Build and install xdg-desktop-portal-termfilechooser and wire it up as the
# FileChooser portal backend, so file dialogs open xplr (see
# filechooser_xplr.sh). Idempotent — safe to re-run, e.g. after a
# xdg-desktop-portal-{gtk,gnome,xapp} package update restores the GTK dialog.
#
# xdg-desktop-portal on Mint 21.3 is 1.14 (< 1.18), which has no portals.conf,
# so backend selection is done the legacy way: remove FileChooser from the
# other backends' .portal files, leaving termfilechooser as the only provider.
set -euo pipefail

REPO="https://github.com/hunkyburrito/xdg-desktop-portal-termfilechooser"
REPO_DIR="$HOME/github/xdg-desktop-portal-termfilechooser"
PORTALS_DIR="/usr/share/xdg-desktop-portal/portals"

# Use meson from the dotfiles venv (pinned in requirements.txt) for both
# configure and install. Venv scripts have absolute shebangs, so sudo runs the
# exact same meson — mixing meson versions between the configure and install
# steps corrupts the install manifest.
DOTFILES="$(dirname "$(dirname "$(dirname "$(realpath "${BASH_SOURCE:-$0}")")")")"
VENV="$DOTFILES/.venv"
MESON="$VENV/bin/meson"
if [ ! -x "$MESON" ]; then
    [ -d "$VENV" ] || uv venv --seed "$VENV"
    "$VENV/bin/pip" install -r "$DOTFILES/requirements.txt"
fi

sudo apt install -y build-essential ninja-build libinih-dev libsystemd-dev scdoc

if [ -d "$REPO_DIR" ]; then
    git -C "$REPO_DIR" pull --ff-only
else
    git clone "$REPO" "$REPO_DIR"
fi

cd "$REPO_DIR"
# Reconfigure from scratch so the build always matches the venv meson, even if
# an older run used a different one.
rm -rf build
"$MESON" setup build
ninja -C build
sudo "$MESON" install -C build --no-rebuild

# Default install prefix is /usr/local, but xdg-desktop-portal 1.14 only scans
# /usr/share/xdg-desktop-portal/portals.
if [ ! -f "$PORTALS_DIR/termfilechooser.portal" ]; then
    sudo cp /usr/local/share/xdg-desktop-portal/portals/termfilechooser.portal "$PORTALS_DIR/"
fi
sudo sed -i 's/^UseIn=.*/UseIn=i3/' "$PORTALS_DIR/termfilechooser.portal"

for backend in gtk gnome xapp; do
    portal="$PORTALS_DIR/$backend.portal"
    [ -f "$portal" ] && sudo sed -i 's/org.freedesktop.impl.portal.FileChooser;//' "$portal"
done

systemctl --user daemon-reload
systemctl --user restart xdg-desktop-portal-termfilechooser.service 2> /dev/null || true
systemctl --user restart xdg-desktop-portal.service

echo
echo "Done. Manual step (once per machine): in Firefox about:config set"
echo "  widget.use-xdg-desktop-portal.file-picker = 1"
echo "then restart Firefox."
