#!/bin/bash

# from https://technologyconversations.com/2017/06/16/automating-jenkins-docker-setup/

set -o errexit -o posix -o pipefail -o nounset

jq --version >/dev/null 2>/dev/null || { printf "jq needed, install first\n"; exit 1; }
curl --version >/dev/null 2>/dev/null || { printf "curl needed, install first\n"; exit 1;}

JENKINS_USER="${JENKINS_USER:-admin}";
JENKINS_PASSWD="${JENKINS_PASSWD:-admin}";
JENKINS_HOST_NAME="${JENKINS_HOST_NAME:-localhost}";
JENKINS_HOST_PORT="${JENKINS_HOST_PORT:-8080}";
JENKINS_HOST_PROTOCOL="${JENKINS_HOST_PROTOCOL:-http}";

# e.g.
# curl -s -k "http://admin:admin@localhost:8080/pluginManager/api/json?depth=1" \
#  | jq -r '.plugins[].shortName'

curl -s -k "${JENKINS_HOST_PROTOCOL}://${JENKINS_USER}:${JENKINS_PASSWD}@${JENKINS_HOST_NAME}:${JENKINS_HOST_PORT}/pluginManager/api/json?depth=1" \
|  jq --raw-output '.plugins[] | .shortName + ":" + .version'
