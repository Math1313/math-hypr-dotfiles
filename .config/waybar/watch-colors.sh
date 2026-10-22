#!/usr/bin/env bash

FILE="$HOME/.config/waybar/colors.css"

while inotifywait -e close_write,move,create,delete "$FILE" 2>/dev/null; do
    pkill -SIGUSR2 waybar
done
