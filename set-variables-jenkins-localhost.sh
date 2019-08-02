#!/bin/bash
# no set options for expand running shell
# set -o errexit -o posix -o pipefail -o nounset
# set repository name
GITHUB_URL=$(git config --get remote.origin.url)
export GITHUB_URL;

# work only on bash
# regex="^(https|git)(:\/\/|@)([^\/:]+)[\/:]([^\/:]+)\/(.+).git$"
# if [[ $github_url =~ $regex ]]; then    
#     # protocol="${BASH_REMATCH[1]}"
#     # separator=${BASH_REMATCH[2]}
#     # hostname=${BASH_REMATCH[3]}
#     user=${BASH_REMATCH[4]}
#     repository=${BASH_REMATCH[5]}
# fi

GITHUB_REPOSITORY_USER="$(echo "${GITHUB_URL}"|cut -d/ -f4)"
GITHUB_REPOSITORY_NAME="$(echo "${GITHUB_URL}"|cut -d/ -f5|cut -d. -f1)"
export GITHUB_REPOSITORY_NAME
GITHUB_REPOSITORY=${GITHUB_REPOSITORY_USER}/${GITHUB_REPOSITORY_NAME};
export GITHUB_REPOSITORY
# localhost payload ip
DOCKER_HOST_IP="$(ip route get 1 | sed 's/^.*src \([^ ]*\).*$/\1/;q')";
export DOCKER_HOST_IP;
# pseudo docker default port
DOCKER_HOST_PORT=2376
export DOCKER_HOST_PORT;
# access with tls
DOCKER_HOST="tcp://$(hostname):2376"
export DOCKER_HOST
# 
DOCKER_TLS_VERIFY=1
export DOCKER_TLS_VERIFY
#
# composer project name for isolate envoiremnet
COMPOSE_PROJECT_NAME="jenkins_for_repository_${GITHUB_REPOSITORY}";
export COMPOSE_PROJECT_NAME;