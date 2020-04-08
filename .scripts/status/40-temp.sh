#!/bin/sh

TEMP="$(sensors | awk '/Package/{print $4}')"
NUMTEMP="$(echo "$TEMP" | tr -dc '0-9')"
if [ "$NUMTEMP" -ge 700 ]; then
    TEMPCOL=""
elif [ "$NUMTEMP" -ge 500 ]; then
    TEMPCOL=""
else
    TEMPCOL=""
fi
echo "$TEMPCOL$TEMP"
