#!/bin/bash

DIR="$HOME/Pictures/Screenshots"
mkdir -p "$DIR"

FILE="$DIR/$(date +'%Y-%m-%d_%H-%M-%S').png"

GEOM=$(slurp)

# Cancelled with Esc
if [ $? -ne 0 ] || [ -z "$GEOM" ]; then
    exit 0
fi

grim -g "$GEOM" "$FILE"

wl-copy < "$FILE"

notify-send "Screenshot saved" "$FILE"
