#!/usr/bin/env bash

sudo pacman -S --needed alacritty brightnessctl hyprlock hyprpaper impala less ttf-jetbrains-mono-nerd neovim swayosd unzip waybar wl-clipboard

cp -rf ~/dotfiles/.config/* ~/.config
cp ~/dotfiles/shell/.bashrc ~/.bashrc

sudo cp -rf ~/dotfiles/usr/share/sddm/themes/omarchy /usr/share/sddm/themes/
sudo cp ~/dotfiles/etc/sddm.conf /etc/
sudo cp ~/dotfiles/scripts/hypr_toggle_theme.sh /bin/toggle-theme
sudo reboot now
