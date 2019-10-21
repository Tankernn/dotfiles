#!/bin/sh

CHOICE=$(dmenu -i -b << EOF
Lock
Sleep
Hibernate
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
        ~/.scripts/lock.sh && sudo zzz
        ;;
    "Hibernate")
        ~/.scripts/lock.sh && sudo ZZZ
        ;;
    "Exit")
        pkill Xorg
        ;;
    "Shutdown")
        sudo poweroff
        ;;
    "Reboot")
        sudo reboot
        ;;
    *)
        ;;
esac

