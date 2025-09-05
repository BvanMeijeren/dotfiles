#!/usr/bin/env bash

# sway status.sh
# Requires: nerd fonts, pactl, nmcli, date

echo '{"version":1}'
echo '['
echo '[],'

get_status() {
    date=$(date '+%Y-%m-%d %H:%M')
    battery=$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null || echo "?")

    # Volume + mute state
    volume=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | head -n1)
    muted=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')

    # Wifi
    wifi=$(nmcli -t -f ACTIVE,SSID dev wifi | grep '^yes' | cut -d: -f2)

    # Battery icons
    if [ "$battery" != "?" ]; then
        if [ "$battery" -gt 80 ]; then bat_icon="󰁹"
        elif [ "$battery" -gt 40 ]; then bat_icon="󰂂"
        else bat_icon="󰁺"; fi
    else
        bat_icon="󰂑"
    fi

    # Volume icons
    if [ "$muted" = "yes" ]; then
        vol_icon="󰖁"   # muted
        volume="0%"
    else
        vol_icon="󰕾"   # normal
    fi

    # Wifi icons
    if [ -n "$wifi" ]; then
        wifi_icon="󰖩"
    else
        wifi_icon="󰖪"
        wifi="offline"
    fi

    # Print JSON array for swaybar
    echo "[\
    {\"full_text\":\"$bat_icon $battery%\"},\
    {\"full_text\":\"$vol_icon $volume\"},\
    {\"full_text\":\"$wifi_icon ${wifi:-offline}\"},\
    {\"full_text\":\"󰅐 $date\"}\
    ],"
}

# Update loop
while true; do
    get_status
    sleep 0
done
