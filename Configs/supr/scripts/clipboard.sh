#!/bin/bash

cliphist list | rofi -dmenu \
    -p "Clipboard" \
    -config "$HOME/.config/rofi/configs/clipboard.rasi" \
    | cliphist decode | wl-copy
