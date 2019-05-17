#!/bin/sh

CHOICE=$(dmenu -i -b << EOF
left-of
below
EOF
)

xrandr --output HDMI-0 --auto --"$CHOICE" DP-2

~/.scripts/set_background.sh
