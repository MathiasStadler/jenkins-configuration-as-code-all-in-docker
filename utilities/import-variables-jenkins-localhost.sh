#!/bin/bash
# composer project name for isolate envoiremnet
export COMPOSE_PROJECT_NAME="jekins_of_local_docker_";
# localhost payload ip
export DOCKER_HOST_IP="$(ip route get 1 | sed 's/^.*src \([^ ]*\).*$/\1/;q')";
# pseudo docker default port
export DOCKER_HOST_PORT=2376
# access with tls
export DOCKER_HOST="tcp://$(hostname):2376"
export DOCKER_TLS_VERIFY=1