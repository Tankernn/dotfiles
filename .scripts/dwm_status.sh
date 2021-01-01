#!/bin/sh

trap 'echo "Caught SIGUSR1"' USR1

while true; do
    STATUS=""
    for section in "$HOME"/.scripts/status/*.sh; do
        out="$($section)"
        [ -z "$out" ] && continue
        if [ -z "$STATUS" ]; then
            STATUS="$out"
        else
            STATUS="$STATUS | $out"
        fi
    done
    xsetroot -name " $STATUS "
    sleep 5 &
    wait $!
done
