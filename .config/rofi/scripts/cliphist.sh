#!/usr/bin/env bash
#  ┏┓┓ ┳┏┓┓┏┳┏┓┏┳┓
#  ┃ ┃ ┃┃┃┣┫┃┗┓ ┃
#  ┗┛┗┛┻┣┛┛┗┻┗┛ ┻
#

## /* ---- 💫 https://github.com/JaKooLit 💫 ---- */ ##
# Clipboard Manager. This script uses cliphist, rofi, and wl-copy.

# Actions:
# CTRL Del to delete an entry
# ALT  Del to wipe clipboard contents

# --- PATCH: Check if rofi is running and kill it to hide the window ---
if pidof rofi > /dev/null; then
    pkill rofi
    exit 0 # Exit cleanly after closing the window
fi
# ---------------------------------------------------------------------

# If rofi was not running, proceed to launch it
result=$(
    rofi -i -dmenu \
        -kb-custom-1 "Control-Delete" \
        -kb-custom-2 "ALT-Delete" \
        -config ~/.config/rofi/applets/cliphist.rasi < <(cliphist list)
)

# After rofi closes, process the result based on the exit code ($?)
case "$?" in
    1)
        # Exit code 1: User pressed Escape or window was closed manually
        exit 0
        ;;
    0)
        # Exit code 0: User made a selection and pressed Enter
        case "$result" in
            "")
                # No selection made, do nothing
                exit 0
                ;;
            *)
                # Decode and copy the selected entry
                cliphist decode <<<"$result" | wl-copy
                exit 0
                ;;
        esac
        ;;
    10)
        # Exit code 10 (Custom-1): Delete entry (CTRL + Del)
        cliphist delete <<<"$result"
        # Relaunch the script to show the updated list
        exec "$0"
        ;;
    11)
        # Exit code 11 (Custom-2): Wipe clipboard (ALT + Del)
        cliphist wipe
        # Relaunch the script to show the updated list
        exec "$0"
        ;;
esac

exit 0
