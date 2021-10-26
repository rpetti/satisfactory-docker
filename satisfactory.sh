#!/bin/bash

export HOME=/home/satisfactory

while(true); do
    state=$(cat /state)
    if [ "$state" != "ready" ]; then
        sleep 1;
    else
        break
    fi
done

/data/Satisfactory/FactoryServer.sh