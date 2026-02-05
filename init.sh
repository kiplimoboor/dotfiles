#!/bin/bash

# apps install
sudo pacman -S --needed alacritty brightnessctl gcc hyprlock hyprpaper less make neovim pipewire-jack swayosd ttf-jetbrains-mono-nerd tree-sitter-cli unzip waybar wget wl-clipboard wofi

# user configs
ln -sf $HOME/.dotfiles/config/* $HOME/.config/
ln -sf $HOME/.dotfiles/bashrc $HOME/.bashrc

# system configs
sudo ln -sf $HOME/.dotfiles/etc/greetd/config.toml /etc/greetd/config.toml
sudo ln -sf $HOME/.dotfiles/etc/systemd/network/25-wireless.network /etc/systemd/network/25-wireless.network

echo "you probably need to reboot"
