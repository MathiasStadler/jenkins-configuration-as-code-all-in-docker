#!/bin/bash -l
set -o errexit -o posix -o pipefail

# check is set

# handle githup repository
#!/bin/bash

# from  https://serverfault.com/questions/417241/extract-repository-name-from-github-url-in-bash
# url="git@github.com:some-user/my-repo.git"
github_url=$(git config --get remote.origin.url)

regex="^(https|git)(:\/\/|@)([^\/:]+)[\/:]([^\/:]+)\/(.+).git$"

if [[ $github_url =~ $regex ]]; then    
    # protocol=${BASH_REMATCH[1]}
    # separator=${BASH_REMATCH[2]}
    # hostname=${BASH_REMATCH[3]}
    user=${BASH_REMATCH[4]}
    repository=${BASH_REMATCH[5]}
fi


if [ -z "$COMPOSE_PROJECT_NAME" ]; then
    printf "# Oops !!! Variable \$COMPOSE_PROJECT_NAME NOT set yet\n"
    printf "# Please set first for isolated\n"
    # check is provide as parameter
    if [ "$#" -ne 1 ]; then
        printf "# e.g.\n"
        printf "export COMPOSE_PROJECT_NAME=\"jenkins_on_docker\"\n"
        printf " used the github repository name\n"
        printf "export COMPOSE_PROJECT_NAME=\"%s\"\n" "${user}/${repository}";
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
