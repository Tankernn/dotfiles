#!/bin/bash

while true; do
    mpc idle player
    pkill --signal=USR1 dwm_status.sh
done
