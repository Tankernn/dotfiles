#!/bin/bash

playerctl pause

scrot /tmp/lock.png
convert /tmp/lock.png -paint 2 /tmp/lock.png
i3lock -i /tmp/lock.png
rm /tmp/lock.png
