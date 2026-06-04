#!/bin/bash

if [ -z "$LABREPORT_DIR" ]; then
    exit 0
fi

find . -type f \
    ! -path "./.git/*" \
    ! -path "./experiments/*" \
    ! -path "./reports/*" \
| while read file
do
    echo "==================================" >> "$LABREPORT_DIR/files.log"
    echo "TIME: $(date)" >> "$LABREPORT_DIR/files.log"
    echo "FILE: $file" >> "$LABREPORT_DIR/files.log"

    head -50 "$file" >> "$LABREPORT_DIR/files.log" 2>/dev/null

    echo "" >> "$LABREPORT_DIR/files.log"
done
