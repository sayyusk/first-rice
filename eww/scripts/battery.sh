#!/usr/bin/env bash
# Averages all batteries (ThinkPads often have two).
total=0; n=0; charging=false
for b in /sys/class/power_supply/BAT*; do
  [ -r "$b/capacity" ] || continue
  total=$(( total + $(<"$b/capacity") ))
  n=$(( n + 1 ))
  [ "$(<"$b/status")" = "Charging" ] && charging=true
done

if [ "$n" -eq 0 ]; then
  echo '{"pct":100,"charging":false,"present":false}'
else
  jq -nc --argjson pct "$(( total / n ))" --argjson charging "$charging" \
    '{pct:$pct, charging:$charging, present:true}'
fi
