#!/bin/bash -l
set -o errexit -o posix -o pipefail

# check is set

if [ -z "$COMPOSE_PROJECT_NAME" ]; then
    printf "# Oops !!! Variable \$COMPOSE_PROJECT_NAME NOT set yet\n"
    printf "# Please set first for isolated\n"
    # check is provide as parameter
    if [ "$#" -ne 1 ]; then
        printf "# e.g.\n"
        printf "export COMPOSE_PROJECT_NAME=\"jenkins_on_docker\"\n"
    else
        printf "# please export in your shell by your self\n"
        printf "export COMPOSE_PROJECT_NAME=\"%s\"\n" "$1"
    fi
else

    if [ "$#" -eq 0 ]; then
        printf "OK: \$COMPOSE_PROJECT_NAME is set to => %s \n" "$COMPOSE_PROJECT_NAME"
        printf " Used for start jenkins\n"
        printf " ./%s %s\n" "${0##*/}" "${COMPOSE_PROJECT_NAME}";

    elif [ "$#" -eq 1 ]; then

        if [ "$1" == "$COMPOSE_PROJECT_NAME" ]; then

            printf "OK: \$COMPOSE_PROJECT_NAME is set to => %s \n" "$COMPOSE_PROJECT_NAME"
            make build-service
            make run-service
        else
            printf "# ATTENTION !!! \$COMPOSE_PROJECT_NAME already set to => %s\n" "$COMPOSE_PROJECT_NAME"
            printf "# Would you lke add an other project?\n"
            printf "# Please set the \"COMPOSE_PROJECT_NAME by hand"
            printf "# e.g.\n"
            printf "export COMPOSE_PROJECT_NAME=\\\"%s\\\"\n" "$1"
            printf "# for unset type\n"
            printf "unset COMPOSE_PROJECT_NAME\n"
        fi
    else
        printf "ERROR: to many argument\n";
        printf "Set only one COMPOSE_PROJECT_NAME\n";
    fi
fi
