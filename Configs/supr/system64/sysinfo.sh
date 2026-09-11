#!/usr/bin/env bash
# System64 / sysinfo.sh — detailed system report
# # Usage: ./sysinfo.sh          print + save to system.txt
#        ./sysinfo.sh --quiet  save only, no terminal output

set -uo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUT_FILE="$SCRIPT_DIR/system.txt"

# colors (no-op if not a terminal)
if [[ -t 1 ]]; then
    C_TITLE='\033[1;36m'; C_LABEL='\033[1;35m'; C_RESET='\033[0m'
else
    C_TITLE=''; C_LABEL=''; C_RESET=''
fi

section() { printf "\n${C_TITLE}%s${C_RESET}\n" "== $1 =="; }
row()     { printf "  ${C_LABEL}%-18s${C_RESET} %s\n" "$1" "$2"; }

# run a command, fall back to "unknown"
safe() {
    local out
    out=$(eval "$1" 2>/dev/null)
    [[ -z "$out" ]] && out="unknown"
    echo "$out"
}

# ---------- gather ----------

OS_NAME=$(safe "source /etc/os-release && echo \$PRETTY_NAME")
KERNEL=$(safe "uname -r")
ARCH=$(safe "uname -m")
UPTIME=$(safe "uptime -p")
INIT_SYS=$(safe "ps -p 1 -o comm=")
LOCALE=$(safe "echo \$LANG")

CPU_MODEL=$(safe "grep -m1 'model name' /proc/cpuinfo | cut -d: -f2 | sed 's/^ *//'")
CPU_CORES=$(safe "nproc --all")
CPU_THREADS=$(safe "grep -c ^processor /proc/cpuinfo")
LOAD_AVG=$(safe "cut -d' ' -f1-3 /proc/loadavg")
TEMP_CPU=$(safe "sensors 2>/dev/null | grep -m1 -Ei 'Package id 0|Tctl|CPU' | awk '{print \$2, \$3}'")

GPU_MODEL=$(safe "lspci | grep -Ei 'vga|3d|display' | cut -d: -f3 | sed 's/^ *//' | head -n1")
GPU_DRIVER=$(safe "lspci -k | grep -A3 -Ei 'vga|3d|display' | grep 'Kernel driver' | awk '{print \$5}' | head -n1")

MEM_TOTAL=$(safe "free -h --si | awk '/^Mem:/ {print \$2}'")
MEM_USED=$(safe "free -h --si | awk '/^Mem:/ {print \$3}'")
SWAP_TOTAL=$(safe "free -h --si | awk '/^Swap:/ {print \$2}'")
SWAP_USED=$(safe "free -h --si | awk '/^Swap:/ {print \$3}'")

DISK_ROOT=$(safe "df -h / | awk 'NR==2 {print \$3\" / \"\$2\" (\"\$5\" used)\"}'")

DISPLAY_SERVER=$(safe "echo \$XDG_SESSION_TYPE")
WM=$(safe "echo \$XDG_CURRENT_DESKTOP")
HYPR_VERSION=$(safe "hyprctl version 2>/dev/null | head -n1")
RESOLUTION=$(safe "hyprctl monitors 2>/dev/null | grep -m1 -oE '[0-9]{3,5}x[0-9]{3,5}'")
MONITOR_COUNT=$(safe "hyprctl monitors 2>/dev/null | grep -c 'Monitor'")

SHELL_NAME=$(safe "basename \$SHELL")
TERMINAL=$(safe "echo \$TERM")

PKG_COUNT=$(safe "pacman -Qq 2>/dev/null | wc -l")
AUR_COUNT=$(safe "pacman -Qqm 2>/dev/null | wc -l")

BATTERY=$(safe "cat /sys/class/power_supply/BAT0/capacity 2>/dev/null")
BATTERY_STATUS=$(safe "cat /sys/class/power_supply/BAT0/status 2>/dev/null")

# ---------- render ----------

render() {
echo -e "${C_TITLE}System64 — detailed report${C_RESET}"
echo "Generated: $(date '+%Y-%m-%d %H:%M:%S')"

section "OS"
row "Distro"        "$OS_NAME"
row "Kernel"        "$KERNEL"
row "Architecture"  "$ARCH"
row "Init system"   "$INIT_SYS"
row "Uptime"        "$UPTIME"
row "Locale"        "$LOCALE"

section "CPU"
row "Model"     "$CPU_MODEL"
row "Cores"     "$CPU_CORES"
row "Threads"   "$CPU_THREADS"
row "Load avg"  "$LOAD_AVG"
row "Temp"      "$TEMP_CPU"

section "GPU"
row "Model"   "$GPU_MODEL"
row "Driver"  "$GPU_DRIVER"

section "Memory"
row "RAM"    "$MEM_USED / $MEM_TOTAL"
row "Swap"   "$SWAP_USED / $SWAP_TOTAL"

section "Storage"
row "Root (/)" "$DISK_ROOT"

section "Display"
row "Session type"  "$DISPLAY_SERVER"
row "WM / DE"        "$WM"
row "Hyprland ver"   "$HYPR_VERSION"
row "Resolution"     "$RESOLUTION"
row "Monitors"       "$MONITOR_COUNT"

section "Shell & Terminal"
row "Shell"     "$SHELL_NAME"
row "Terminal"  "$TERMINAL"

section "Packages"
row "Official"    "$PKG_COUNT"
row "AUR/foreign" "$AUR_COUNT"

if [[ -n "$BATTERY" && "$BATTERY" != "unknown" ]]; then
    section "Battery"
    row "Charge"  "${BATTERY}%"
    row "Status"  "$BATTERY_STATUS"
fi
echo ""
}

# strip color codes for the saved file
render | sed -E 's/\x1B\[[0-9;]*[a-zA-Z]//g' > "$OUT_FILE"

if [[ "${1:-}" != "--quiet" ]]; then
    render
fi
