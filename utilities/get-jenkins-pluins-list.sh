#!/bin/bash

# from https://technologyconversations.com/2017/06/16/automating-jenkins-docker-setup/

set -o errexit -o posix

echo "start"

jq --version >/dev/null 2>/dev/null || { printf "jq needed, install first\n"; exit 1; }
curl --version >/dev/null 2>/dev/null || { printf "curl needed, install first\n"; exit 1;}

USER="admin"
PASSWD="admin"
HOST_NAME="localhost"
HOST_PORT="8080"

# curl -s -k "http://admin:admin@localhost:8080/pluginManager/api/json?depth=1" \
#  | jq -r '.plugins[].shortName'

curl -s -k "http://${USER}:${PASSWD}@${HOST_NAME}:${HOST_PORT}/pluginManager/api/json?depth=1" \
  | jq -r '.plugins[].shortName'