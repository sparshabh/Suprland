#!/usr/bin/bash

notif="$HOME/.config/supr/assets/logo.png"

case "$1" in
    on)
        rfkill block wifi
        notify-send -u low -i "$notif" "Airplane Mode" "ON"
        ;;

    off)
        rfkill unblock wifi
        notify-send -u low -i "$notif" "Airplane Mode" "OFF"
        ;;

    *)
        echo "Usage: $0 {on|off}"
        exit 1
        ;;
esac
