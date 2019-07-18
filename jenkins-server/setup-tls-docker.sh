#!/bin/bash
set -o errexit -o posix

if ! [ -d "/var/jenkins_home/.docker" ]; then
    mkdir /var/jenkins_home/.docker
fi

ln -s /run/secrets/docker-ca.pem /var/jenkins_home/.docker/ca.pem
ln -s /run/secrets/docker-cert.pem /var/jenkins_home/.docker/cert.pem
ln -s /run/secrets/docker-key.pem /var/jenkins_home/.docker/key.pem

