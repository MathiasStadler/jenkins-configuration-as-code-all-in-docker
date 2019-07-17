#!/bin/bash

set -o errexit -o posix

if [ -z "$COMPOSE_PROJECT_NAME" ]; then
    printf "\$COMPOSE_PROJECT_NAME => NOT SET\n"
else
    printf "\$COMPOSE_PROJECT_NAME => %s\n" "$COMPOSE_PROJECT_NAME"
fi;
