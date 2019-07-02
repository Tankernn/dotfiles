#!/bin/sh

CHOICE=$(dmenu -i -b << EOF
Lock
Sleep
Exit
Shutdown
Reboot
EOF
)

case $CHOICE in
    "Lock")
        ~/.scripts/lock.sh
        ;;
    "Sleep")
        ~/.scripts/lock.sh && echo mem | sudo /usr/bin/tee /sys/power/state
        ;;
    "Exit")
        i3-msg exit
        ;;
    "Shutdown")
        sudo shutdown -h now
        ;;
    "Reboot")
        reboot
        ;;
    *)
        ;;
esac

