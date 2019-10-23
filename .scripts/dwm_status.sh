#!/bin/sh

while true; do
    MUSIC="$(playerctl metadata artist) - $(playerctl metadata title)"
    MEM="$(free -h | awk '(NR==2){ print $3 }')"
    VOL="$(amixer get Master | awk -F'[][]' 'END{ print $4":"$2 }')"
    TEMP="$(sensors | awk '/Package/{print $4}')"
    DATE="$(date +"%F %T")"
    xsetroot -name " $MUSIC | $VOL | $MEM | $TEMP | $DATE"
    sleep 5
done
