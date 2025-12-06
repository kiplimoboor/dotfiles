#!/usr/bin/env bash

CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"
THEME_DIR="$CONFIG_DIR/theme"
THEME_FILE="$THEME_DIR/mode"
CURRENT_THEME=$(cat "$THEME_FILE") 

if [[ "$CURRENT_THEME" == "light" ]]; then
	NEW="dark"
	chromium --no-startup-window --set-color-scheme=dark
	chromium --no-startup-window --set-theme-color=24,24,36
else
	NEW="light"
	chromium --no-startup-window --set-color-scheme=light
	chromium --no-startup-window --set-theme-color=242,240,229
fi

## nvim
for addr in $XDG_RUNTIME_DIR/nvim.*; do
	if [ -S "$addr" ]; then
		if [[ "$NEW" == "light" ]]; then
			nvim --server "$addr" --remote-send ":set background=dark<CR>|:colorscheme flexoki-light<CR>"
		else
			nvim --server "$addr" --remote-send ":set background=dark<CR>|:colorscheme catppuccin<CR>"
		fi
	fi
done
cp "$THEME_DIR/nvim/$NEW.lua" "$CONFIG_DIR/nvim/lua/custom/plugins/colorscheme.lua"

## alacritty
cp "$THEME_DIR/alacritty/$NEW.toml" "$CONFIG_DIR/alacritty/alacritty.toml"

## hyprpaper
cp "$THEME_DIR/hypr/hyprpaper-$NEW.conf" "$CONFIG_DIR/hypr/hyprpaper.conf"
hyprctl hyprpaper reload ,"$THEME_DIR/wallpaper/$NEW.png"

## waybar
cp "$THEME_DIR/waybar/$NEW.css" "$CONFIG_DIR/waybar/style.css"
pkill -x waybar
setsid uwsm-app -- waybar >/dev/null 2>&1 &


## hyprlock
cp "$THEME_DIR/hypr/hyprlock-$NEW.conf" "$CONFIG_DIR/hypr/hyprlock.conf"



## swayosd
cp "$THEME_DIR/swayosd/$NEW.css" "$CONFIG_DIR/swayosd/style.css"
pkill -x swayosd-server
setsid uwsm-app -- swayosd-server >/dev/null 2>&1 &


## wofi
cp "$THEME_DIR/wofi/$NEW.css" "$CONFIG_DIR/wofi/style.css"

## update theme mode file
echo "$NEW" > "$THEME_FILE"
