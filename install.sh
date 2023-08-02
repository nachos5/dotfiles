#!/bin/bash

SCRIPT_PATH="${BASH_SOURCE:-$0}"
ABS_SCRIPT_PATH="$(realpath "${SCRIPT_PATH}")"
ABS_DIRECTORY="$(dirname "${ABS_SCRIPT_PATH}")"
DOTFILES=$ABS_DIRECTORY

rm -rf ~/.config/i3 && ln -sf "${DOTFILES}/.config/i3" ~/.config/i3
rm -rf ~/.config/i3status && ln -sf "${DOTFILES}/.config/i3status" ~/.config/i3status
rm -rf ~/.config/nvim && ln -sf "${DOTFILES}/.config/nvim" ~/.config/nvim
mkdir -p ~/.config/lazygit && ln -sf "${DOTFILES}/.config/lazygit/config.yml" ~/.config/lazygit/config.yml
mkdir -p ~/.config/stylua && ln -sf "${DOTFILES}/.config/stylua/.stylua.toml" ~/.config/stylua/.stylua.toml
mkdir -p ~/i3status-rust && ln -sf "${DOTFILES}/i3status-rust/config.toml" ~/i3status-rust/config.toml
mkdir -p ~/.config/xplr && ln -sf "${DOTFILES}/.config/xplr/init.lua" ~/.config/xplr/init.lua
mkdir -p ~/.config/dunst && ln -sf "${DOTFILES}/.config/dunst/dunstrc" ~/.config/dunst/dunstrc
rm -rf ~/utils && ln -sf "${DOTFILES}/utils" ~/utils
ln -sf "${DOTFILES}/.bash_aliases" ~/.bash_aliases
ln -sf "${DOTFILES}/.inputrc" ~/.inputrc
ln -sf "${DOTFILES}/.psqlrc" ~/.psqlrc
ln -sf "${DOTFILES}/.tmux.conf" ~/.tmux.conf
ln -sf "${DOTFILES}/.xprofile" ~/.xprofile
ln -sf "${DOTFILES}/.wezterm.lua" ~/.wezterm.lua
ln -sf "${DOTFILES}/.local/bin/tmux-sessionizer" ~/.local/bin/tmux-sessionizer
ln -sf "${DOTFILES}/.tridactylrc" ~/.tridactylrc

if ! grep -q "if \[ -f ~/.bashrc \]; then" ~/.bash_profile; then
	echo "if [ -f ~/.bashrc ]; then" >>~/.bash_profile
	echo "  . ~/.bashrc" >>~/.bash_profile
	echo "fi" >>~/.bash_profile
fi

if ! grep -q "if \[ -f ~/.bash_aliases \]; then" ~/.bashrc; then
	echo "if [ -f ~/.bash_aliases ]; then" >>~/.bashrc
	echo "  . ~/.bash_aliases" >>~/.bashrc
	echo "fi" >>~/.bashrc
fi

if ! grep -q "export EDITOR=nvim" ~/.bashrc; then
	echo "export EDITOR=nvim" >>~/.bashrc
fi

if ! grep -q "# set PS1" ~/.bashrc; then
	echo "# set PS1" >>~/.bashrc
	echo "PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '" >>~/.bashrc
fi
