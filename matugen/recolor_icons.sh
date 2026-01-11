#!/bin/bash
# $1=Back, $2=Flap, $3=Paper, $4=Symbol
BACK=${1:-5c7ed7}
FLAP=${2:-4c69ba}
PAPER=${3:-ffffff}
SYMBOL=${4:-202020}

# Find where the SVGs actually are in this specific theme
TARGET_DIR=$(find "$HOME/.icons/Colloid-Matugen-Dark" -name "folder.svg" -exec dirname {} \; | head -n 1)

if [ -d "$TARGET_DIR" ]; then
  for file in "$TARGET_DIR"/*.svg; do
    sed -i -e "s/5c7ed7/$BACK/gI" \
      -e "s/4c69ba/$FLAP/gI" \
      -e "s/ffffff/$PAPER/gI" \
      -e "s/555555/$SYMBOL/gI" "$file"

    # Strip opacity
    sed -i "s/opacity[:=][\"']0.2[\"']//gI" "$file"
  done
fi

# Refresh
gtk-update-icon-cache -q -f "$HOME/.icons/Colloid-Matugen-Dark"
gsettings set org.gnome.desktop.interface icon-theme 'Adwaita'
sleep 0.2
gsettings set org.gnome.desktop.interface icon-theme 'Colloid-Matugen-Dark'
