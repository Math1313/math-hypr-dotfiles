#!/bin/bash

# Dossier où sont stockés tes images ou thèmes
WALLPAPER_DIR="$HOME/Images/wallpapers"

# Liste des fichiers, passer à fuzzel
CHOICE=$(ls "$WALLPAPER_DIR" | fuzzel --dmenu --prompt "Theme Switcher  ")

# Fermer si rien n'est choisi
[ -z "$CHOICE" ] && exit 0

# Appliquer le nouveau fond d'écran et le thème de couleur
awww img "$WALLPAPER_DIR/$CHOICE" && wallust run "$WALLPAPER_DIR/$CHOICE"

# Mettre à jour le thème de Pywalfox
#pywalfox update

# Mettre à jour le thème de Fuzzel
./update-fuzzel-theme.sh

# Remettre le focus sur les fenêtres
hyprctl dispatch focuscurrentorlast
