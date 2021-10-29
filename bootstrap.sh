#!/bin/bash

chown -R satisfactory /data/Satisfactory /saves

/usr/bin/supervisord -c /etc/supervisord.conf