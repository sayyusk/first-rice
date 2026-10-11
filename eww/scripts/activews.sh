#!/usr/bin/env bash
# Streams just the active workspace number (used to slide the highlight pill).
active() { hyprctl activeworkspace -j | jq -r '.id'; }

active
socat -u "UNIX-CONNECT:${XDG_RUNTIME_DIR}/hypr/${HYPRLAND_INSTANCE_SIGNATURE}/.socket2.sock" - |
while read -r line; do
  case $line in
    workspace*|focusedmon*|moveworkspace*) active ;;
  esac
done
