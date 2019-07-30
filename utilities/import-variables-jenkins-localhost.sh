#!/bin/bash
set -o errexit -o posix -o pipefail -o nounset
# composer project name for isolate envoiremnet
COMPOSE_PROJECT_NAME="jenkins_of_local_docker";
export COMPOSE_PROJECT_NAME
# localhost payload ip
DOCKER_HOST_IP="$(ip route get 1 | sed 's/^.*src \([^ ]*\).*$/\1/;q')";
export DOCKER_HOST_IP
# pseudo docker default port
export DOCKER_HOST_PORT=2376
# access with tls
DOCKER_HOST="tcp://$(hostname):2376"
export DOCKER_HOST
#
DOCKER_TLS_VERIFY=1
export DOCKER_TLS_VERIFY