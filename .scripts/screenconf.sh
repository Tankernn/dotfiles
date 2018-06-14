#!/bin/bash

CHOICE=$(echo -e "left-of\nbelow" | dmenu)

xrandr --output HDMI-0 --auto --$CHOICE DP-2

~/.scripts/set_background.sh
