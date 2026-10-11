#!/usr/bin/env bash
# usage: toggle.sh wifi|bt|dnd
export LC_ALL=C
case "$1" in
  wifi)
    if [ "$(nmcli radio wifi)" = "enabled" ]; then nmcli radio wifi off; else nmcli radio wifi on; fi ;;
  bt)
    if bluetoothctl show | grep -q 'Powered: yes'; then
      bluetoothctl power off
    else
      rfkill unblock bluetooth; bluetoothctl power on
    fi ;;
  dnd)
    swaync-client -d -sw ;;
esac
eww poll wifi bt 2>/dev/null
