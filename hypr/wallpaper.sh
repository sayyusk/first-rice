#!/usr/bin/env bash
# change this to your wallpaper, or pass a path as the first argument
WALLPAPER="${1:-$HOME/wallpapers/reiwallpaper.webp}"

# start the daemon if it isn't already running
pgrep -x awww-daemon >/dev/null || setsid awww-daemon >/dev/null 2>&1 &

# wait until the daemon is ready, otherwise awww img fails at boot
until awww query >/dev/null 2>&1; do sleep 0.2; done

awww img "$WALLPAPER" --transition-type fade --transition-duration 1