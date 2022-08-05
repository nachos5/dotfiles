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
rm -rf ~/utils && ln -sf "${DOTFILES}/utils" ~/utils
ln -sf "${DOTFILES}/.bash_aliases" ~/.bash_aliases
ln -sf "${DOTFILES}/.inputrc" ~/.inputrc
ln -sf "${DOTFILES}/.tmux.conf" ~/.tmux.conf

if ! grep -q "if \[ -f ~/.bashrc \]; then" ~/.bash_profile; then
  echo "if [ -f ~/.bashrc ]; then" >> ~/.bash_profile
  echo "  . ~/.bashrc" >> ~/.bash_profile
  echo "fi" >> ~/.bash_profile
fi

if ! grep -q "if \[ -f ~/.bash_aliases \]; then" ~/.bashrc; then
  echo "if [ -f ~/.bash_aliases ]; then" >> ~/.bashrc
  echo "  . ~/.bash_aliases" >> ~/.bashrc
  echo "fi" >> ~/.bashrc
fi

if ! grep -q "export EDITOR=nvim" ~/.bashrc; then
  echo "export EDITOR=nvim" >> ~/.bashrc
fi
