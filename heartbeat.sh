#!/bin/bash

while (true); do
    if ( supervisorctl status satisfactory | grep -q RUNNING ); then
        if [ -n "$HEARTBEAT_URL" ]; then
            curl -k $HEARTBEAT_URL
        fi
    fi
    sleep ${HEARTBEAT_INTERVAL:-30}
done