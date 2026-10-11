#!/usr/bin/env bash
# usage: popup.sh quick|calendar|powermenu   (toggles it, closes the others)
target=$1
for w in quick calendar powermenu; do
  [ "$w" != "$target" ] && eww close "$w" 2>/dev/null
done
eww open --toggle "$target"
