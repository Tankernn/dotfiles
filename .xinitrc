#!/bin/sh

xrandr --output DVI-I-1 --auto --left-of DP-2
xrandr --output HDMI-0 --mode 3840x2160 --rate 59.94 --right-of DP-2

xset s off
xset s noblank
xset -dpms

[ -f ~/.Xresources ] && xrdb -merge -I"$HOME" ~/.Xresources

start-pulseaudio-x11 &

exec dwm
