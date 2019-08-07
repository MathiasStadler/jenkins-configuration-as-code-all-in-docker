#!/bin/bash
set -o errexit -o posix -o nounset

# setup tls for docker
bash +x /setup-tls-docker.sh
# change ${JENKINS_HOME} permission
# TODO check for delete
# TODO disable bash +x /jenkins-home-change-permission.sh
# start jenkins 
# script inherit from parent images
/sbin/tini -- /usr/local/bin/jenkins.sh

# HINT ::
# NO exec "$@" here because it is include in jenkins.sh script