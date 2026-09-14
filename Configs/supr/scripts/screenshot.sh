#!/usr/bin/env bash

DIR="$HOME/Pictures/Screenshots"
mkdir -p "$DIR"

FILE="$DIR/$(date +'%Y-%m-%d_%H-%M-%S').png"

# Select and screenshot
GEOM=$(slurp)

# Cancelled
if [ $? -ne 0 ] || [ -z "$GEOM" ]; then
    exit 0
fi

# Save screenshot
grim -g "$GEOM" "$FILE"

# Copy to clipboard
wl-copy --type image/png < "$FILE"

# Store clipboard in cliphist
wl-paste --type image/png | cliphist store

# Notification
notify-send "Screenshot saved" "$FILE"
