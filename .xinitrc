#!/bin/sh

xrandr --output DVI-I-1 --auto --left-of DP-2
xrandr --output HDMI-0 --mode 3840x2160 --rate 59.94 --right-of DP-2

xset s off
xset s noblank
xset -dpms

[ -f ~/.Xresources ] && xrdb -merge -I"$HOME" ~/.Xresources

start-pulseaudio-x11 &

# test for an existing bus daemon, just to be safe
if test -z "$DBUS_SESSION_BUS_ADDRESS" ; then
    # if not found, launch a new one
    eval `dbus-launch --sh-syntax --exit-with-session`
    echo "D-Bus per-session daemon address is: $DBUS_SESSION_BUS_ADDRESS"
fi

export GTK_IM_MODULE='ibus'
export QT_IM_MODULE='ibus'
export XMODIFIERS='@im=ibus'
ibus-daemon &

python -m pywal -R
setxkbmap -layout se

compton &
sxhkd &
~/.scripts/dwm_status.sh &

exec ck-launch-session dwm
