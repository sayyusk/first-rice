#!/usr/bin/env bash
on=false; ssid=""; signal=0
if [ "$(nmcli radio wifi 2>/dev/null)" = "enabled" ]; then
  on=true
  line=$(nmcli -t -f ACTIVE,SIGNAL,SSID dev wifi 2>/dev/null | grep '^yes' | head -n1)
  if [ -n "$line" ]; then
    IFS=: read -r _ signal ssid <<<"$line"
    ssid=${ssid//\\/}
  fi
fi
jq -nc --argjson on "$on" --arg ssid "$ssid" --argjson signal "${signal:-0}" \
  '{on:$on, ssid:$ssid, signal:$signal}'
