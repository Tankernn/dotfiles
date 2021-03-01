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
        ~/.scripts/lock.sh; xset dpms force standby
        ;;
    "Sleep")
        ~/.scripts/lock.sh && dbus-send \
            --system \
            --print-reply \
            --dest=org.freedesktop.login1 \
            /org/freedesktop/login1 \
            org.freedesktop.login1.Manager.Suspend \
            boolean:false
        ;;
    "Hibernate")
        ~/.scripts/lock.sh && dbus-send \
                  --system \
                  --print-reply \
                  --dest=org.freedesktop.login1 \
                  /org/freedesktop/login1 \
                  org.freedesktop.login1.Manager.Hibernate \
                  boolean:false
        ;;
    "Exit")
        pkill Xorg
        ;;
    "Shutdown")
        dbus-send \
                  --system \
                  --print-reply \
                  --dest=org.freedesktop.login1 \
                  /org/freedesktop/login1 \
                  org.freedesktop.login1.Manager.PowerOff \
                  boolean:false

        ;;
    "Reboot")
        dbus-send \
                  --system \
                  --print-reply \
                  --dest=org.freedesktop.login1 \
                  /org/freedesktop/login1 \
                  org.freedesktop.login1.Manager.Reboot \
                  boolean:false

        ;;
    *)
        ;;
esac

