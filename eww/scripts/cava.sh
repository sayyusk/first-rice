#!/usr/bin/env bash
# Audio visualizer: runs cava and streams one line of block characters per frame.
# needs:  sudo pacman -S cava
cfg=$(mktemp)
trap 'pkill -P $$ 2>/dev/null; rm -f "$cfg"' EXIT

cat > "$cfg" <<'EOF'
[general]
bars = 14
framerate = 30
sleep_timer = 3

[input]
method = pulse
source = auto

[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = 7
bar_delimiter = 59
frame_delimiter = 10

[smoothing]
noise_reduction = 60
EOF

cava -p "$cfg" | sed -u 's/;//g; y/01234567/▁▂▃▄▅▆▇█/'
