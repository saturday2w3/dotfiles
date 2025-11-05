#!/bin/bash

WALL="$1"
[ -z "$WALL" ] && WALL=$(find ~/Pictures/Wallpapers -type f | shuf -n 1)

swww img "$WALL" --transition-type any --transition-fps 60 --transition-duration 1

wal -i "$WALL" --backend kitty

kitty @ set-colors --all --all-fonts ~/.cache/wal/kitty.conf

ln -sf ~/.cache/wal/colors-waybar.css ~/.config/waybar/colors.css
ln -sf ~/.cache/wal/colors-rofi-dark.rasi ~/.config/rofi/colors.rasi
ln -sf ~/.cache/wal/colors-hyprland.conf ~/.config/hypr/colors.conf

hyprctl reload
killall waybar 2>/dev/null && waybar &

~/.local/bin/update-cava-colors.sh &

neofetch

~/.local/bin/wal-to-kew.sh
