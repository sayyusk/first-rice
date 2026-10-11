#!/usr/bin/env bash
# LC_ALL=C: nmcli translates "enabled"/"yes" into your language (e.g. Czech),
# which made the old checks fail. IN-USE ('*') is locale independent.
export LC_ALL=C
on=false; ssid=""; signal=0
if [ "$(nmcli radio wifi 2>/dev/null)" = "enabled" ]; then
  on=true
  line=$(nmcli -t -f IN-USE,SIGNAL,SSID dev wifi 2>/dev/null | grep -m1 '^\*')
  if [ -n "$line" ]; then
    IFS=: read -r _ signal ssid <<<"$line"
    ssid=${ssid//\\/}
  fi
fi
jq -nc --argjson on "$on" --arg ssid "$ssid" --argjson signal "${signal:-0}" \
  '{on:$on, ssid:$ssid, signal:$signal}'
