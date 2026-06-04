#!/bin/bash

if [ -z "$LABREPORT_DIR" ]; then
    exit 0
fi

SNAP_DIR="$LABREPORT_DIR/snapshots"

mkdir -p "$SNAP_DIR"

find . -type f \
    ! -path "./.git/*" \
    ! -path "./experiments/*" \
    ! -path "./reports/*" \
| while read file
do

    HASH=$(md5sum "$file" | awk '{print $1}')

    CACHE_FILE="$SNAP_DIR/$(echo "$file" | sed 's/\//_/g').md5"

    if [ -f "$CACHE_FILE" ]; then

        OLD_HASH=$(cat "$CACHE_FILE")

        if [ "$OLD_HASH" = "$HASH" ]; then
            continue
        fi
    fi

    echo "==================================" >> "$LABREPORT_DIR/files.log"
    echo "TIME: $(date)" >> "$LABREPORT_DIR/files.log"
    echo "FILE: $file" >> "$LABREPORT_DIR/files.log"
    echo "" >> "$LABREPORT_DIR/files.log"

    head -50 "$file" >> "$LABREPORT_DIR/files.log" 2>/dev/null

    echo "" >> "$LABREPORT_DIR/files.log"
    echo "" >> "$LABREPORT_DIR/files.log"

    echo "$HASH" > "$CACHE_FILE"

done
