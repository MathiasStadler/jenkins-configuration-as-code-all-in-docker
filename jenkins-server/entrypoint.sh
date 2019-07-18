#!/bin/bash

set -o errexit -o posix

# setup tls for docker
bash +x /setup-tls-docker.sh
# start jenkins 
# script inherit from parent images
/sbin/tini -- /usr/local/bin/jenkins.sh

# NO exec "$@" here because it is include in jenkins.sh script