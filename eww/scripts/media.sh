#!/usr/bin/env bash
# Streams the current track as JSON; "Stopped" when no player is running.
playerctl --follow metadata --format '{{status}}|||{{artist}}|||{{title}}' 2>/dev/null |
while IFS= read -r line; do
  jq -nc --arg l "$line" '
    ($l | split("|||")) as $p
    | ($p[1] // "") as $a
    | ($p[2] // "") as $t
    | {
        status: (if $t == "" then "Stopped" else ($p[0] // "Stopped") end),
        label:  (if $a == "" then $t else $a + " – " + $t end)
      }'
done
