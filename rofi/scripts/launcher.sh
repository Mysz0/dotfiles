#!/usr/bin/env bash
#  ┓ ┏┓┳┳┳┓┏┓┓┏┏┓┳┓
#  ┃ ┣┫┃┃┃┃┃ ┣┫┣ ┣┫
#  ┗┛┛┗┗┛┛┗┗┛┛┗┗┛┛┗
#
# Style-dir
theme_file="$HOME/.config/rofi/launcher.rasi"

# Run
if pgrep -u "$USER" -x rofi >/dev/null; then
  pkill -u "$USER" -x rofi
else
  rofi -show drun -theme "$theme_file" &
fi
