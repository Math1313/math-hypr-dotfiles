#!/bin/bash

# Lire les couleurs de pywal
colors=( $(cat ~/.cache/wal/colors) )

# Fonction pour transformer #RRGGBB en #FFRRGGBB
remove_hashtag() {
    echo "${1#\#}"
}

background=$(remove_hashtag "${colors[0]}")
foreground=$(remove_hashtag "${colors[1]}")
color1=$(remove_hashtag "${colors[4]}")
color4=$(remove_hashtag "${colors[7]}")

# Générer le fichier fuzzel.ini
mkdir -p ~/.config/fuzzel

cat > ~/.config/fuzzel/fuzzel.ini <<EOF
[main]
font = JetBrains Mono:size=12
prompt = " "
width = 50
lines = 10
horizontal-pad = 20
vertical-pad = 20
line-height = 28
border-width = 2

[colors]
background = ${background}ff
text = ${color4}ff
match = ${color4}ff
selection = ${foreground}dd
selection_match = ${color1}ff
selection-text = ${color4}ff
border = ${foreground}ff
EOF

