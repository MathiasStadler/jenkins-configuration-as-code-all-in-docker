#!/bin/bash

# usage:
# . ./set-host-ip.sh
DOCKER_HOST_IP="$(ip route get 1 | sed 's/^.*src \([^ ]*\).*$/\1/;q')";
export DOCKER_HOST_IP;
# pseudo docker default port
DOCKER_HOST_PORT=2376
export DOCKER_HOST_PORT