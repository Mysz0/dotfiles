#!/bin/bash

player_status=$(playerctl status 2>/dev/null)

if [ "$player_status" = "Playing" ] || [ "$player_status" = "Paused" ]; then
  artist=$(playerctl metadata artist 2>/dev/null)
  title=$(playerctl metadata title 2>/dev/null)
  pos=$(playerctl position 2>/dev/null | cut -d'.' -f1)
  len=$(playerctl metadata mpris:length 2>/dev/null)

  if [ -z "$len" ] || [ "$len" -eq 0 ]; then
    echo " $artist - $title"
  else
    len_sec=$((len / 1000000))
    # Bar length (30 characters)
    bar_size=30
    percent=$((pos * 100 / len_sec))
    filled=$((percent * bar_size / 100))
    empty=$((bar_size - filled))

    # Spotify-style solid bar characters
    bar=""
    for i in $(seq 1 $filled); do bar+="━"; done
    for i in $(seq 1 $empty); do bar+="─"; done

    p_m=$((pos / 60))
    p_s=$((pos % 60))
    l_m=$((len_sec / 60))
    l_s=$((len_sec % 60))

    # Output formatted for the hyprlock label
    echo -e "  $title\n$artist\n$bar\n$(printf "%02d:%02d / %02d:%02d" $p_m $p_s $l_m $l_s)"
  fi
else
  echo ""
fi
