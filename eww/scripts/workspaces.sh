#!/usr/bin/env bash
# Streams workspace state as JSON on every Hyprland event.
spaces() {
  active=$(hyprctl activeworkspace -j | jq '.id')
  hyprctl workspaces -j | jq -c --argjson active "${active:-1}" '
    . as $ws
    | [range(1; 6)]
    | map(. as $i | {
        id: $i,
        active: ($i == $active),
        occupied: ([$ws[] | select(.id == $i and .windows > 0)] | length > 0)
      })'
}

spaces
socat -u "UNIX-CONNECT:${XDG_RUNTIME_DIR}/hypr/${HYPRLAND_INSTANCE_SIGNATURE}/.socket2.sock" - |
while read -r line; do
  case $line in
    workspace*|focusedmon*|createworkspace*|destroyworkspace*|openwindow*|closewindow*|movewindow*|moveworkspace*)
      spaces ;;
  esac
done
