#!/bin/bash

apt update
apt install -y nodejs npm net-tools

echo "Downloading app..."
wget https://node-envvars-artifact.s3.eu-west-2.amazonaws.com/bootcamp-node-envvars-project-1.0.0.tgz
tar xvf bootcamp-node-envvars-project-1.0.0.tgz

echo "Exporting vars..."
export APP_ENV=dev
export DB_USER=myuser
export DB_PWD=mysecret

NEW_USER=myapp

echo -n "Set log directory location for the application (absolute path): "
read -r LOG_DIRECTORY
if [ -d "$LOG_DIRECTORY" ]; then
    echo "$LOG_DIRECTORY already exists"
else
    mkdir -p "$LOG_DIRECTORY"
    echo "A new directory $LOG_DIRECTORY has been created"
fi

useradd $NEW_USER -m
chown $NEW_USER -R "$LOG_DIRECTORY"
chown $NEW_USER -R package

echo "Starting app..."
runuser -l $NEW_USER -c "
    export APP_ENV=dev && 
    export DB_PWD=mysecret && 
    export DB_USER=myuser && 
    export LOG_DIR=$LOG_DIRECTORY && 
    cd package && 
    npm install && 
    node server.js &"

echo "Checking app status..."
ps aux | grep node | grep -v grep

netstat -ltnp | grep :3000
