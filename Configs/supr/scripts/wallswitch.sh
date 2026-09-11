#!/usr/bin/env bash
source "$HOME/.config/supr/System64/logger.sh"

ROFI_THEME="$HOME/.config/rofi/configs/wallswitch.rasi"
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
CACHE_DIR="$HOME/.cache/supr"

mkdir -p "$CACHE_DIR"

selected=$(
    find "$WALLPAPER_DIR" -maxdepth 1 -type f \
        \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) \
        -printf "%f\0" |
    sort -z |
    while IFS= read -r -d '' wallpaper; do
        printf '%s\0icon\x1f%s\n' "$wallpaper" "$WALLPAPER_DIR/$wallpaper"
    done |
    rofi -dmenu \
        -config "$ROFI_THEME" \
        -i \
        -p "Wallpaper"
)

[ -z "$selected" ] && exit 0

WALLPAPER="$WALLPAPER_DIR/$selected"

if ! pgrep -x "awww-daemon" > /dev/null; then
    awww-daemon &

    for i in {1..20}; do
        awww query &>/dev/null && break
        sleep 0.2
    done
fi

awww img "$WALLPAPER" \
    --transition-type center \
    --transition-fps 60 \
    --transition-duration 0.5 ||
    log_error "awww failed to set wallpaper: $WALLPAPER"

if command -v magick &>/dev/null; then
    magick "$WALLPAPER" "$CACHE_DIR/current_wallpaper.jpg" ||
        log_error "magick conversion failed"
else
    cp "$WALLPAPER" "$CACHE_DIR/current_wallpaper.jpg" ||
        log_error "wallpaper cache copy failed"
fi

chmod 644 "$CACHE_DIR/current_wallpaper.jpg"
chmod +x "$HOME" "$HOME/.cache" "$CACHE_DIR"

matugen image "$WALLPAPER" \
    --source-color-index 0 ||
    log_error "matugen failed"

# Send notifcation
notify-send -u low -i ~/.config/supr/assets/logo.png -a Wallswitch  "New Look!" "System Wallpaper, Color and Theme updated"
