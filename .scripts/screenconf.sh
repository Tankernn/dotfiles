#!/bin/bash

CHOICE=$(echo -e "left-of\nbelow" | dmenu)

xrandr --output HDMI-0 --auto --$CHOICE DP-2

~/bin/set_background.sh
