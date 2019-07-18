#!/bin/bash

# usage:
# . ./set-host-ip.sh

export DOCKER_HOST_IP="$(ip route get 1 | sed 's/^.*src \([^ ]*\).*$/\1/;q')";