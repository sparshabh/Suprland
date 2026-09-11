#!/usr/bin/env bash
source ~/.config/supr/System64/logger.sh

# Wallpaper Daemon
if ! pgrep -x "awww-daemon" > /dev/null; then
    awww-daemon &
    for i in {1..20}; do
        if awww query &>/dev/null; then
            break
        fi
        sleep 0.2
    done
fi
# Clear to black first 
awww clear 000000 \
  || log_error "awww clear failed"
sleep 1

# Colors
matugen image ~/.cache/supr/current_wallpaper.jpg --source-color-index 0 \
  || log_error "matugen failed to generate colors"

# Set wallpaper
awww img ~/.cache/supr/current_wallpaper.jpg --transition-type center --transition-fps 60 --transition-step 30 --transition-duration 1.5 \
  || log_error "awww img failed to set wallpaper"
sleep 1

# Bar
~/.config/waybar/scripts/launch.sh

# Cursor
hyprctl setcursor Bibata-Modern-Ice 20 \
  || log_error "hyprctl setcursor failed"

# Others
systemctl --user start hyprpolkitagent.service
pgrep -x hypridle >/dev/null || hypridle &

# Clipboard
wl-paste --type text --watch cliphist store &
wl-paste --type image --watch cliphist store &

