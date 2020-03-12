#!/bin/sh

playerctl pause

maim /tmp/lock.png
convert /tmp/lock.png -blur 0x8 /tmp/lock.png
i3lock -i /tmp/lock.png
rm /tmp/lock.png
