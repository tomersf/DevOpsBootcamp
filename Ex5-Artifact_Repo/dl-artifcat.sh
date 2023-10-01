#!/bin/bash

set -xe

user=$NEXO_USER
password=$NEXO_PASSWORD

if [ -z "$user" ] || [ -z "$password" ]; then
    echo "Error: NEXO_USER or NEXO_PASSWORD environment variable is not set."
    exit 1
fi

curl -u "$user":"$password" -X GET 'http://64.227.122.44:8081/service/rest/v1/components?repository=my-npm&sort=version' | jq "." >artifact.json

artifactDownloadUrl=$(jq '.items[].assets[].downloadUrl' artifact.json --raw-output)

wget --http-user="$user" --http-password="$password" "$artifactDownloadUrl"
