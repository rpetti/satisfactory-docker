#!/bin/bash

while(true); do
    state=$(cat /home/satisfactory/state)
    if [ "$state" != "ready" ]; then
        sleep 1;
    else
        break
    fi
done

/data/Satisfactory/FactoryServer.sh