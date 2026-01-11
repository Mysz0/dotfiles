#!/usr/bin/env bash
#  ┓ ┏┓┳┳┳┓┏┓┓┏┏┓┳┓
#  ┃ ┣┫┃┃┃┃┃ ┣┫┣ ┣┫
#  ┗┛┛┗┗┛┛┗┗┛┛┗┗┛┛┗
#
# Style-dir
style_dir="$HOME/.config/rofi/launchers/styles"

# Style-theme
style_theme='style-1'

# Run
if pgrep -u "$USER" -x rofi >/dev/null; then
  pkill -u "$USER" -x rofi
else
  rofi -show drun -theme "${style_dir}/${style_theme}.rasi" &
fi
