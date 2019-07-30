#!/bin/bash

set -o errexit -o posix -o pipefail -o nounset

DOCKER_COMPOSE_SERVICE="$(docker-compose ps --services)";

if [ "$(docker-compose ps -q |wc -l)" -eq 0 ] ; then
printf "service %s NOT running\n" "${DOCKER_COMPOSE_SERVICE}";
else
printf "service %s running\n" "${DOCKER_COMPOSE_SERVICE}";
fi