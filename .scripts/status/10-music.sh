#!/bin/sh
if playerctl metadata; then
    echo "$(playerctl metadata artist) - $(playerctl metadata title)"
else
    mpc current
fi
