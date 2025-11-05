#!/bin/bash

WALLDIR="$HOME/Pictures/Wallpapers"
CACHE_DIR="$HOME/.cache/wallpaper-picker"
PREVIEW_WIDTH=380
PREVIEW_HEIGHT=580

# Create cache directory for thumbnails
mkdir -p "$CACHE_DIR"

# Generate thumbnail cache with rounded corners
generate_thumbnails() {
    find "$WALLDIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) | while read -r img; do
        filename=$(basename "$img")
        cache_file="$CACHE_DIR/${filename%.*}.png"
        
        # Only generate if doesn't exist or is older than original
        if [ ! -f "$cache_file" ] || [ "$img" -nt "$cache_file" ]; then
            convert "$img" -resize "${PREVIEW_WIDTH}x${PREVIEW_HEIGHT}^" -gravity center -extent "${PREVIEW_WIDTH}x${PREVIEW_HEIGHT}" \
                \( +clone -alpha extract -draw "fill black polygon 0,0 0,15 15,0 fill white circle 15,15 15,0" \
                \( +clone -flip \) -compose Multiply -composite \
                \( +clone -flop \) -compose Multiply -composite \
                \) -alpha off -compose CopyOpacity -composite "$cache_file" 2>/dev/null
        fi
        
        # Output in format: img:path:text:filename
        echo -e "img:${cache_file}:text:${filename}\t${img}"
    done
}

# Generate thumbnails and pipe to wofi
STYLE_PATH="$HOME/.config/wofi/wallpaper-style.css"
CONFIG_PATH="$HOME/.config/wofi/wallpaper-config"

SELECTED=$(generate_thumbnails | wofi --dmenu \
    --conf "${CONFIG_PATH}" \
    --style "${STYLE_PATH}" | cut -f2)

# Exit if user cancels
[ -z "$SELECTED" ] && exit

# Set the wallpaper
~/.config/hypr/scripts/setwall.sh "$SELECTED"
