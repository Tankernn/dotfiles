#!/bin/sh

CHOICE=$(dmenu -i -b << EOF
osu
drawing
EOF
)

ID=$(xsetwacom --list | gawk 'match($0, /id: ([0-9]+).*STYLUS/, a) {print a[1]}')

case $CHOICE in
    osu)
        xsetwacom set $ID Area 0 0 $(calc 2560 \* 3) $(calc 1440 \* 3)
        ;;
    drawing)
        xsetwacom set $ID Area 0 0 21600 $(calc 21600 \* 1440 / 2560)
        ;;
esac

xsetwacom set $ID MapToOutput DisplayPort-1
