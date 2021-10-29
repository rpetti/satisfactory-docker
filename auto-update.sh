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
        # run again with --delete just to make sure any old files are deleted (logs, etc)
        rsync -ari --delete /data/SatisfactoryUpdate/ /data/Satisfactory/
        restart
    else
        echo Checked for updates but none found
    fi
    echo "ready" > /home/satisfactory/state
}

echo "not-ready" > /home/satisfactory/state

while(true); do
    update
    sleep ${AUTO_UPDATE_INTERVAL:-3600}
done
