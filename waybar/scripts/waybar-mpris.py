#!/usr/bin/env python3
import subprocess
import sys
import json
import os
import re

# Configuration
BARS = 8
BAR_CHARS = [" ", "⡀", "⣀", "⣄", "⣤", "⣦", "⣶", "⡷", "⣿"]

def get_theme_color():
    """Parses colors.css from the parent directory to get a distinctive color."""
    try:
        # Looking for colors.css in the parent directory as requested
        color_file = os.path.expanduser("~/.config/waybar/colors.css")
        with open(color_file, "r") as f:
            content = f.read()
            # Using 'tertiary' for a distinctive look compared to the main 'primary'
            match = re.search(r'@define-color tertiary\s+(#[0-9a-fA-F]+)', content)
            if match:
                return match.group(1)
    except Exception:
        pass
    return "#c4c3eb" # Fallback distinctive lavender

# Get the color once at startup
BAR_COLOR = get_theme_color()

def get_info():
    try:
        title = subprocess.check_output(["playerctl", "metadata", "title"], text=True, stderr=subprocess.DEVNULL).strip()
        status = subprocess.check_output(["playerctl", "status"], text=True, stderr=subprocess.DEVNULL).strip()
        display_title = title[:20] + ".." if len(title) > 20 else title
        return display_title, status
    except:
        return "", "Stopped"

# CAVA Setup
config = """
[general]
bars = 8
[input]
method = pulse
source = auto
[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = 8
"""

proc = subprocess.Popen(["cava", "-p", "/dev/stdin"], stdin=subprocess.PIPE, stdout=subprocess.PIPE, text=True)
proc.stdin.write(config)
proc.stdin.close()

for line in proc.stdout:
    title, status = get_info()
    
    if status == "Playing":
        raw = line.strip().split(';')
        levels = [int(v) for v in raw if v.isdigit()]
        
        if levels and any(v > 0 for v in levels):
            bars = "".join([BAR_CHARS[v] for v in levels])
            # Bars now use the Tertiary color from your CSS
            text = f"󰎆  {title}  <span color='{BAR_COLOR}' size='small'>{bars}</span>"
        else:
            text = f"󰎆  {title}"
            
        print(json.dumps({"text": text, "class": "playing"}))
        
    elif status == "Paused":
        print(json.dumps({"text": f"󰏤 {title}", "class": "paused"}))
    else:
        print(json.dumps({"text": "", "class": "stopped"}))
    
    sys.stdout.flush()
