#!/bin/sh
maim -us screenshot.png

UUID=$(uuidgen)
UUID="${UUID[*]:0:5}"

scp screenshot.png "frans@tankernn.eu:/srv/www/scr/$UUID.png"

echo "http://scr.tankernn.eu/$UUID.png" | xsel --clipboard
