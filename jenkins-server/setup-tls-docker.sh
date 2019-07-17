#!/bin/bsh
set -o errexit -o posix

mkdir /var/jenkins_home/.docker

ln -s /run/secrets/docker-ca.pem /var/jenkins_home/.docker/ca.pem
ln -s /run/secrets/docker-cert.pem /var/jenkins_home/.docker/cert.pem
ln -s /run/secrets/docker-key.pem /var/jenkins_home/.docker/key.pem

exit 0;