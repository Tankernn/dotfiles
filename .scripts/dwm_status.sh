#!/bin/sh

trap 'echo "Caught SIGUSR1"' USR1

while true; do
    STATUS=""
    for section in "$HOME"/.scripts/status/*.sh; do
        if [ -z "$STATUS" ]; then
            STATUS="$($section)"
        else
            STATUS="$STATUS | $($section)"
        fi
    done
    xsetroot -name " $STATUS"
    sleep 5 &
    wait $!
done
