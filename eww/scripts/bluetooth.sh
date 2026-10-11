#!/usr/bin/env bash
on=false; device=""
if bluetoothctl show 2>/dev/null | grep -q 'Powered: yes'; then
  on=true
  device=$(bluetoothctl devices Connected 2>/dev/null | head -n1 | cut -d' ' -f3-)
fi
jq -nc --argjson on "$on" --arg device "$device" '{on:$on, device:$device}'
