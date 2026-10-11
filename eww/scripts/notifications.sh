#!/usr/bin/env bash
# Streams notification count / do-not-disturb state from SwayNotificationCenter.
if ! command -v swaync-client >/dev/null 2>&1; then
  echo '{"count":0,"dnd":false}'
  exec sleep infinity
fi

swaync-client -swb | jq --unbuffered -c '{
  count: (((.text // "0") | tonumber?) // 0),
  dnd:   ((.alt // "") | test("dnd"))
}'
