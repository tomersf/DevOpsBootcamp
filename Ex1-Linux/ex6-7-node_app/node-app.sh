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

echo "Starting app..."
cd package || exit
npm install
node server.js &

echo "Checking app status..."
ps aux | grep node | grep -v grep
