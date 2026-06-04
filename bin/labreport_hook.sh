#!/bin/bash

labreport_log() {

    if [ -z "$LABREPORT_DIR" ]; then
        return
    fi

    CMD=$(history 1 | sed 's/^ *[0-9]* *//')

    echo "==================================" >> "$LABREPORT_DIR/commands.log"
    echo "TIME: $(date)" >> "$LABREPORT_DIR/commands.log"
    echo "CMD : $CMD" >> "$LABREPORT_DIR/commands.log"
}
