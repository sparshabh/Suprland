#!/usr/bin/env bash

STATE="$HOME/.cache/supr-gamemode"
NOTIF="$HOME/.config/supr/assets/logo.png"

enable_gamemode() {

    # Stop file indexing
    systemctl --user stop \
        tracker-miner-fs-3.service \
        tracker-extract-3.service \
        >/dev/null 2>&1

    # Disable Hyprland visual effects
    hyprctl eval 'hl.config({
        animations = { enabled = false },
        decoration = {
            blur = { enabled = false },
            shadow = { enabled = false },
            rounding = 0
        },
        general = {
            gaps_in = 0,
            gaps_out = 0,
            border_size = 1
        }
    })'

    # Stop desktop UI
    pkill -x waybar 2>/dev/null
    pkill -x matugen 2>/dev/null
    pkill -x swaync 2>/dev/null

    # Steam and Sober are intentionally untouched

    mkdir -p "$HOME/.cache"
    touch "$STATE"

    notify-send -u low -i "$NOTIF" \
        "Gamemode:" \
        "enabled"
}

disable_gamemode() {

    # Restore indexing
    systemctl --user start \
        tracker-miner-fs-3.service \
        tracker-extract-3.service \
        >/dev/null 2>&1

    # Restore your actual Lua configuration
    hyprctl reload

    # Restore desktop UI
    waybar >/dev/null 2>&1 &
    awww-daemon >/dev/null 2>&1 &

    rm -f "$STATE"

    notify-send -u low -i "$NOTIF" \
        "Gamemode:" \
        "disabled"
}

# ==========================================
# TOGGLE
# ==========================================

if [[ -f "$STATE" ]]; then
    disable_gamemode
else
    enable_gamemode
fi
