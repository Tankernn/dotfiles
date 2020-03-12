#!/bin/sh -e

PLAYLIST="$1" # Playlist directory
SERVER="$2"   # Target RTMP server

while true; do
    for i in $PLAYLIST/*.{mp4,mkv}; do
        BASENAME="${i%.*}"
        ffmpeg -i "$i" \
            -c:v mpeg2video -b:v 9000k -f mpegts -
            #-vf "ass=$BASENAME.enUS.ass"\
    done
done | mbuffer -q -m 100M | ffmpeg -re -i pipe:0 -f flv -b:v 9000k "$SERVER"

