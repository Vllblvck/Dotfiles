#!/bin/sh

rofi_command="rofi -theme ~/.config/rofi/powermenu.rasi"

# Options
shutdown="shutdown"
reboot="reboot"
lock="lock"
logout="logout"

# Variable Passed To Rofi
options="$shutdown\n$reboot\n$lock\n$logout"

chosen="$(echo -e "$options" | $rofi_command -dmenu -selected-row 0)"
case $chosen in
    $shutdown)
        systemctl poweroff
        ;;
    $reboot)
        systemctl reboot
        ;;
    $lock)
        betterlockscreen -l blur
        ;;
    $logout)
        i3-msg exit
        ;;
esac
