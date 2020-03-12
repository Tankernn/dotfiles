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
        ~/.scripts/lock.sh && xset dpms force standby
        ;;
    "Sleep")
        ~/.scripts/lock.sh && sudo s2ram
        ;;
    "Hibernate")
        ~/.scripts/lock.sh && {sudo ZZZ || sudo pm-hibernate }
        ;;
    "Exit")
        pkill X
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

