#!/bin/sh

CHOICE=$(dmenu -i -b << EOF
osu
drawing
EOF
)

case $CHOICE in
    osu)
        xsetwacom set 13 Area 0 0 $(calc 2560 \* 3) $(calc 1440 \* 3)
        ;;
    drawing)
        xsetwacom set 13 Area 0 0 21600 $(calc 21600 \* 1440 / 2560)
        ;;
esac

xsetwacom set 13 MapToOutput DisplayPort-1
