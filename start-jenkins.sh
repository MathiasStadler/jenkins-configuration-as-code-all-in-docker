#!/bin/bash -l
set -o errexit -o posix -o nounset -o pipefail

# check is set

if [ -z "$COMPOSE_PROJECT_NAME" ]; then
    printf "# Oops !!! Variable \$COMPOSE_PROJECT_NAME NOT set yet\n"
    printf "# Please set first for isolated\n"
    # check is provide as parameter
    if [ "$#" -ne 1 ]; then
        printf "# e.g.\n"
        printf "export COMPOSE_PROJECT_NAME=\"jenkins-casc\"\n"
    else
        printf "# please export in your shell by your self\n"
        printf "export COMPOSE_PROJECT_NAME=\"%s\"\n" "$1"
    fi
    exit 1
else
    if [ "$#" -ne 1 ]; then
        printf "OK: \$COMPOSE_PROJECT_NAME is set to => %s \n" "$COMPOSE_PROJECT_NAME"
    else
        printf "# ATTENTION !!! \$COMPOSE_PROJECT_NAME already set to => %s\n" "$COMPOSE_PROJECT_NAME"
        printf "# Would you lke add an other project?\n"
        printf "# Please set the \"COMPOSE_PROJECT_NAME by hand"
        printf "# e.g.\n"
        printf "export \$COMPOSE_PROJECT_NAME=\"%s\"\n" "$1"
        printf "# for unset type\n"
        printf "unset COMPOSE_PROJECT_NAME"
        exit 1
    fi
fi

make build-service
make run-service
