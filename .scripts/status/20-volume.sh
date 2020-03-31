#!/bin/sh
pulseaudio-ctl full-status | awk '{print $1 "%" ($2 == "yes" ? " (muted)" : "")}'
