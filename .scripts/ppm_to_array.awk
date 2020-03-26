#!/usr/bin/awk -f

# Converts a ppm P3 file to a C-compatible array of the coordinates of all pixels
# with an intensity lesser than THRESHOLD (0-255)

BEGIN {
    i = -3
    THRESHOLD = 150
}

/^[0-9]+\ [0-9]+$/ {
    width = $1
}

/^[0-9]+$/ {
    color += $1
    if (++i % 3 == 0) {     # Three rows define a pixel's color
        pixel = i / 3
        row = int(pixel / width)
        column = pixel % width
        if (color < 3 * THRESHOLD)
            print "{" column "," row "},"
        color = 0
    }
}
