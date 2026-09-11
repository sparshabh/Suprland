---------------------
------ PROGRAMS -----
---------------------

local M = {}

M.terminal = "kitty"
M.fileManager = "nautilus"
M.menu = "rofi -show drun"
M.browser = "zen-browser"
M.waybarrestart = "~/.config/waybar/scripts/launch.sh"

M.wallswitch = "~/.config/supr/scripts/wallswitch.sh"
M.emoji = "~/.config/supr/scripts/emoji.sh"
M.clipboard = "~/.config/supr/scripts/clipboard/clipboard.sh"
M.gamemode = "~/.config/supr/scripts/gamemode.sh"

M.vscode = "code"
M.spotify = "spotify"
M.discord = "vesktop"
M.swaync = "swaync-client -t"

M.screenshot = [[grim -g "$(slurp)" "$HOME/Pictures/Screenshots/$(date +'%Y-%m-%d_%H-%M-%S').png"]]
M.screenshotmonitor = [[grim "$HOME/Pictures/Screenshots/$(date +'%Y-%m-%d_%H-%M-%S').png"]]

M.logout = "wlogout -b 5"
M.lockscreen = "hyprlock"
M.bluetooth = "blueman-manager"

return M
