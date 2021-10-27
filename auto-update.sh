#!/bin/bash

restart () {
    supervisorctl restart satisfactory
    echo server restarted
}

update () {
    mkdir -p /data/SatisfactoryUpdate
    steamcmd +login anonymous +force_install_dir /data/SatisfactoryUpdate +app_update 1690800 +quit
    rsyncresults=$(rsync -ari /data/SatisfactoryUpdate/ /data/Satisfactory/)
    if [ -n "$rsyncresults" ]; then
        echo No restart needed
    else
        # run again with --delete just to make sure any old files are deleted (logs, etc)
        rsync -ari --delete /data/SatisfactoryUpdate/ /data/Satisfactory/
        restart
    fi
    echo "ready" > /state
}

echo "not-ready" > /state

while(true); do
    update
    sleep ${AUTO_UPDATE_INTERVAL:-3600}
done