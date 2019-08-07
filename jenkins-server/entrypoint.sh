#!/bin/bash
set -o errexit -o posix -o nounset

# change ${JENKINS_HOME} permission
# TODO disable bash +x /jenkins-home-change-permission.sh
# su jenkins
# TODO disable su - jenkins
# setup tls for user jenkins
bash +x /setup-tls-docker.sh
# start jenkins 
# script inherit from parent images
/sbin/tini -- /usr/local/bin/jenkins.sh
# HINT ::
# NO exec "$@" here because it is include in jenkins.sh script