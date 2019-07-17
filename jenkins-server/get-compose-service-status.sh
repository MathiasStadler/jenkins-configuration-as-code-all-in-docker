#!/bin/bash

set -o errexit -o posix
DOCKER_COMPOSE_SERVICE="$(docker-compose ps --services)";

if [ "$(docker-compose ps -q |wc -l)" -eq 0 ] ; then
printf "service %s NOT runnuning\n" "${DOCKER_COMPOSE_SERVICE}";
else
printf "service %s runnuning\n" "${DOCKER_COMPOSE_SERVICE}";
fi