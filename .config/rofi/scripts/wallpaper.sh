#!/usr/bin/env bash
# WallSelect - Wallpaper selector with caching, GIF support, automatic Rofi image generation
# Uses matugen image to set the wallpaper directly
# Add --random argument to pick a random wallpaper

wall_dir="$HOME/Pictures/Wallpapers"
cacheDir="$HOME/.cache/wallcache"
rofi_img_dir="$HOME/.config/rofi/images"

mkdir -p "$cacheDir" "$rofi_img_dir"

# Focused monitor info
focused_monitor=$(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name')
monitor_width=$(hyprctl monitors -j | jq -r --arg mon "$focused_monitor" '.[] | select(.name == $mon) | .width')
scale_factor=$(hyprctl monitors -j | jq -r --arg mon "$focused_monitor" '.[] | select(.name == $mon) | .scale')

# Icon size for Rofi
icon_size=$(echo "scale=2; ($monitor_width * 14) / ($scale_factor * 96)" | bc)
rofi_override="element-icon{size:${icon_size}px;}"
rofi_command="rofi -i -show -dmenu -theme $HOME/.config/rofi/applets/wallSelect.rasi -theme-str $rofi_override"

# Limit parallel jobs
PARALLEL_JOBS=2

process_image() {
    local imagen="$1"
    local nombre_archivo=$(basename "$imagen")
    local cache_file="${cacheDir}/${nombre_archivo}"
    local md5_file="${cacheDir}/.${nombre_archivo}.md5"
    local lock_file="${cacheDir}/.lock_${nombre_archivo}"

    [[ "$imagen" =~ \.gif$ ]] && return

    local current_md5=$(xxh64sum "$imagen" | cut -d' ' -f1)

    (
        flock -x 200
        if [ ! -f "$cache_file" ] || [ ! -f "$md5_file" ] || [ "$current_md5" != "$(cat "$md5_file" 2>/dev/null)" ]; then
            magick -limit memory 256MB -limit map 512MB "$imagen" -resize 500x500^ -gravity center -extent 500x500 "$cache_file"
            echo "$current_md5" > "$md5_file"
        fi
        rm -f "$lock_file"
    ) 200>"$lock_file"
}

export -f process_image
export wall_dir cacheDir

# Clean old locks
rm -f "${cacheDir}"/.lock_* 2>/dev/null || true

# Process images safely
find "$wall_dir" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) -print0 |
    xargs -0 -P "$PARALLEL_JOBS" -I {} bash -c 'process_image "{}"'

# Clean orphaned cache files
for cached in "$cacheDir"/*; do
    [ -f "$cached" ] || continue
    original="${wall_dir}/$(basename "$cached")"
    if [ ! -f "$original" ]; then
        nombre_archivo=$(basename "$cached")
        rm -f "$cached" \
            "${cacheDir}/.${nombre_archivo}.md5" \
            "${cacheDir}/.lock_${nombre_archivo}"
    fi
done

rm -f "${cacheDir}"/.lock_* 2>/dev/null || true

# Kill existing rofi instances
pidof rofi &>/dev/null && pkill rofi

# Determine wallpaper selection method
if [[ "$1" == "--random" ]]; then
    wall_selection=$(find "$wall_dir" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" -o -iname "*.gif" \) | shuf -n1)
    wall_selection=$(basename "$wall_selection")
else
    # Launch Rofi for selection
    wall_selection=$(find "$wall_dir" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" -o -iname "*.gif" \) -print0 |
        xargs -0 basename -a |
        LC_ALL=C sort -V |
        while IFS= read -r A; do
            if [[ "$A" =~ \.gif$ ]]; then
                printf "%s\n" "$A"
            else
                printf '%s\x00icon\x1f%s/%s\n' "$A" "${cacheDir}" "$A"
            fi
        done | $rofi_command)
fi

# Start swww daemon if not running (needed for matugen)
swww query || swww-daemon --format xrgb

# Apply selected wallpaper using matugen directly
if [[ -n "$wall_selection" ]]; then
    full_path="${wall_dir}/${wall_selection}"

    # Set wallpaper and generate colors
    matugen image "$full_path"

    # Wait briefly for matugen to finish applying
    sleep 0.5

    # Generate Rofi preview images
    magick "$full_path" -strip -resize 1000 -gravity center -extent 1000 -blur 0x30 -quality 90 "$rofi_img_dir/currentWalBlur.thumb"
    magick "$full_path" -strip -resize 1000 -gravity center -extent 1000 -quality 90 "$rofi_img_dir/currentWal.thumb"
    magick "$full_path" -strip -thumbnail 500x500^ -gravity center -extent 500x500 "$rofi_img_dir/currentWal.sqre"
    magick "$rofi_img_dir/currentWal.sqre" \
        \( -size 500x500 xc:white -fill "rgba(0,0,0,0.7)" \
        -draw "polygon 400,500 500,500 500,0 450,0" -fill black \
        -draw "polygon 500,500 500,0 450,500" \) \
        -alpha Off -compose CopyOpacity -composite "$rofi_img_dir/currentWalQuad.quad"

    # Notification
    notify-send -e -h string:x-canonical-private-synchronous:wallnotif \
        "Wallpaper Changed" "New wallpaper set successfully" -i "$full_path"
fi

