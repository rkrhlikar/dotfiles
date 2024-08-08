#!/usr/bin/env bash

power_menu=' 󰐥 Power Menu '

lock=' Lock'
shutdown='󰗽 Shutdown'
reboot=' Reboot'
logout='󰗽 Logout'

rofi_cmd() {
    rofi -dmenu -mesg "$1" \
        -theme-str 'window { width: 400px; height: 300px; }' \
        -theme-str 'mainbox { children: ["message", "listview"]; }'
}

run_power_menu() {
    echo -e "$lock\n$shutdown\n$reboot\n$logout" | rofi_cmd "${power_menu}"
}

chosen="$(run_power_menu)"

case ${chosen} in
    $lock)
        i3lock
        ;;
    $shutdown)
        systemctl poweroff
        ;;
    $reboot)
        systemctl reboot
        ;;
    $logout)
        i3-msg exit
        ;;
esac

