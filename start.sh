#!/bin/sh
set -m

mongodb_cmd="mongod --bind_ip 0.0.0.0"
cmd="$mongodb_cmd"

if [ "$AUTH" == "yes" ]; then
    cmd="$cmd --auth"
fi

$cmd &

if [ ! -f /data/db/.configured ]; then
    /configure-mongo.sh
fi

fg