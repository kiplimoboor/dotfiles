#!/bin/bash

mkdir -p $HOME/.config

# user configs
ln -sf $HOME/.dotfiles/config/* $HOME/.config/
ln -sf $HOME/.dotfiles/bashrc $HOME/.bashrc

# apps install
sudo pacman --sync --needed alacritty brightnessctl gcc greetd-tuigreet hyprland hyprlock hyprpaper less make neovim openssh pipewire-jack ripgrep swayosd ttf-jetbrains-mono-nerd tree-sitter-cli unzip uwsm waybar wget wl-clipboard wofi

echo "you probably need to reboot"
