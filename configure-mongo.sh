#!/bin/sh

# ADMIN user
ADMIN_USER=${ADMIN_USER:-"admin"}
ADMIN_PASS=${ADMIN_PASS:-"admin"}

# APP user
APPLICATION_DATABASE=${APPLICATION_DATABASE:-"admin"}
APPLICATION_USER=${APPLICATION_USER:-"user"}
APPLICATION_PASS=${APPLICATION_PASS:-"user"}

# Wait for MongoDB to initialize
COUNTER=0
while !(nc -z localhost 27017) && [ $COUNTER -lt 60 ] ; do
    sleep 1
    COUNTER=$((COUNTER+1))
    echo "Waiting for mongo to initialize... ($COUNTER seconds so far)"
done

# Create the admin user
echo "Creating ADMIN user for Mongo..."

mongo admin << EOF
db.createUser({user: '$ADMIN_USER', pwd: '$ADMIN_PASS', roles:[{role:'root',db:'admin'}]});
EOF

sleep 3

if [ "$APPLICATION_DATABASE" != "admin" ]; then
    echo "=> Creating a ${APPLICATION_DATABASE} database user with a password in MongoDB"
    mongo admin -u $ADMIN_USER -p $ADMIN_PASS << EOF
use $APPLICATION_DATABASE
db.createUser({user: '$APPLICATION_USER', pwd: '$APPLICATION_PASS', roles:[{role:'dbOwner', db:'$APPLICATION_DATABASE'}]})
EOF
fi

sleep 1

touch /data/db/.configured

echo "Mongo ready for use"
