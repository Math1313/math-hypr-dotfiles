#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/Images/wallpapers"

CHOICE=$(
    find "$WALLPAPER_DIR" -maxdepth 1 -type f \
        \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) \
        -printf "%f\n" | sort | \
        fuzzel --dmenu --prompt "󰸉 Wallpaper"
)

[ -z "$CHOICE" ] && exit 0

wallust run "$WALLPAPER_DIR/$CHOICE"
