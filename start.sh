#!/bin/sh
set -m

if [ ! -f /data/db/.configured ]; then
    mongodb_cmd="mongod --bind_ip localhost"
    cmd="$mongodb_cmd"

    $cmd &
    PID=$!

    /configure-mongo.sh
    kill -9 $PID
    
    mongodb_cmd="mongod --bind_ip 0.0.0.0"
    cmd="$mongodb_cmd"

    if [ "$AUTH" == "yes" ]; then
        cmd="$cmd --auth"
    fi
    $cmd
else
    mongodb_cmd="mongod --bind_ip 0.0.0.0"
    cmd="$mongodb_cmd"

    if [ "$AUTH" == "yes" ]; then
        cmd="$cmd --auth"
    fi
    $cmd
fi