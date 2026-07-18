#!/usr/bin/env bash

power_menu=' 󰐥 Power Menu '

lock=' Lock'
shutdown='󰗽 Shutdown'
reboot=' Reboot'
logout='󰗽 Logout'

tofi_cmd() {
    tofi --prompt-text="$1" \
        --hide-input=true \
        --hidden-character=""
}

run_power_menu() {
    echo -e "$lock\n$shutdown\n$reboot\n$logout" | tofi_cmd "${power_menu}"
}

chosen="$(run_power_menu)"

case ${chosen} in
    $lock)
        swaylock
        ;;
    $shutdown)
        systemctl poweroff
        ;;
    $reboot)
        systemctl reboot
        ;;
    $logout)
        swaymsg exit
        ;;
esac

