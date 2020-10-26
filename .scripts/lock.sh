#!/bin/sh

playerctl pause

SIZE="$(xrandr | awk -F, '/Screen 0/ { print $2 }' | awk '{print $2 "x" $4 }')"
maim -u | convert - -paint 2 RGB:- | i3lock --raw "$SIZE":rgb -i /dev/stdin
