#!/bin/bash

sleep 3
# =======================
# CONFIG
# =======================
GOVEE_IP="192.168.68.103"
CSS_FILE="$HOME/.config/matugen/colors.css"

# =======================
# READ COLOR
# =======================
if [[ ! -f "$CSS_FILE" ]]; then
  echo "❌ CSS file not found at $CSS_FILE"
  exit 1
fi

HEX=$(grep -oP '@define-color source_color \K#[0-9a-fA-F]{6}' "$CSS_FILE")

if [[ -z "$HEX" ]]; then
  echo "❌ Could not find primary color in CSS"
  exit 1
fi

HEX="${HEX#\#}"

R=$((16#${HEX:0:2}))
G=$((16#${HEX:2:2}))
B=$((16#${HEX:4:2}))

echo "Sending color → R=$R G=$G B=$B"

# =======================
# SEND RGB COLOR TO GOVEE
# =======================
JSON=$(printf '{"msg":{"cmd":"colorwc","data":{"color":{"r":%d,"g":%d,"b":%d},"colorTemInKelvin":0}}}' "$R" "$G" "$B")

echo "$JSON" | socat - UDP4-DATAGRAM:$GOVEE_IP:4003

echo "✅ Done!"
