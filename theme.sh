#!/bin/bash

theme=$(cat "$HOME/.dotfiles/theme")

if [[ "$theme" == "light" ]]; then
	new="dark"
	chromium --no-startup-window --set-color-scheme=dark
	chromium --no-startup-window --set-theme-color=24,24,36
else
	new="light"
	chromium --no-startup-window --set-color-scheme=light
	chromium --no-startup-window --set-theme-color=242,240,229
fi

cp -rf ~/.dotfiles/$new/* ~/.dotfiles/config/

pkill -x waybar
setsid uwsm-app -- waybar >/dev/null 2>&1 &
pkill -x swayosd-server
setsid uwsm-app -- swayosd-server >/dev/null 2>&1 &
hyprctl hyprpaper wallpaper ,"$HOME/.dotfiles/wallpapers/$new.png",

## nvim
for addr in $XDG_RUNTIME_DIR/nvim.*; do
	if [ -S $addr ]; then
		if [[ $new == "light" ]]; then
			nvim --server $addr --remote-send ":set background=dark<CR>|:colorscheme flexoki-light<CR>"
		else
			nvim --server $addr --remote-send ":set background=dark<CR>|:colorscheme catppuccin<CR>"
		fi
	fi
done


echo $new > $HOME/.dotfiles/theme

# sudo reboot
