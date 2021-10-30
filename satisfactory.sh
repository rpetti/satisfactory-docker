#!/bin/bash

while(true); do
    state=$(cat /home/satisfactory/state)
    if [ "$state" != "ready" ]; then
        sleep 1;
    else
        break
    fi
done

kill_descendant_processes() {
    local pid="$1"
    local and_self="${2:-false}"
    echo Stopping $pid
    if children="$(pgrep -P "$pid")"; then
        for child in $children; do
            kill_descendant_processes "$child" true
        done
    fi
    if [[ "$and_self" == true ]]; then
        kill "$pid"
    fi
    while(pgrep -P "$pid" > /dev/null); do
        sleep 1
    done
}

trap "kill_descendant_processes $$" EXIT

/data/Satisfactory/FactoryServer.sh