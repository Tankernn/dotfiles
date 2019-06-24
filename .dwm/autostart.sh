#!/bin/sh
# dwm autostart script

wal -R
setxkbmap -layout se

pkill compton; compton &
pkill sxhkd; sxhkd &
pkill dwm_status.sh; ~/.scripts/dwm_status.sh &
discord &
pgrep redshift-gtk || redshift-gtk &
pgrep ckb-next || ckb-next -b &
