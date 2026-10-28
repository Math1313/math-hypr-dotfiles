#!/bin/bash

# Dossier où sont stockés les profiles de moniteurs
LAYOUT_DIR="$HOME/.config/monique/profiles/"
CONFIG_FILE="$HOME/.config/monique/settings.json"

# Liste des fichiers, passer à fuzzel
CHOICE=$(ls "$LAYOUT_DIR" | fuzzel --dmenu --prompt "Monitor Layout Switcher 󰍹")

# Fermer si rien n'est choisi
[ -z "$CHOICE" ] && exit 0

# Retirer l'extension si les profils sont des fichiers (ex: laptop.json -> laptop)
NAME="${CHOICE%.*}"

# Mettre à jour le JSON de façon atomique
TMP=$(mktemp)
jq --arg name "$NAME" '
  .pinned_profile.name = $name
  | .active_profile = $name
' "$CONFIG_FILE" > "$TMP" && mv "$TMP" "$CONFIG_FILE"
