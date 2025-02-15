
#!/bin/bash

chosen=$(echo -e "Shutdown\nReboot\nLogout" | wofi -dmenu -p "Power Menu")

case "$chosen" in
    Shutdown) systemctl poweroff ;;
    Reboot) systemctl reboot ;;
    Logout) hyprctl dispatch exit ;;
    *) exit 1 ;;
esac
