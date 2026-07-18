#!/bin/bash

lock=''
shutdown='󰐥'
reboot=''
logout='󰍃'

rofi_cmd() {
    rofi -dmenu \
        -theme ~/.config/sway/rofi/power_menu.rasi
}

run_power_menu() {
    echo -e "$lock\n$shutdown\n$reboot\n$logout" | rofi_cmd
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

