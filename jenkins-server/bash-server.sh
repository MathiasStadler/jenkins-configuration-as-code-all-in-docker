#!/bin/bash
set -o errexit -p posix

pushd jenkins-server
docker-compose ps -q jenkins >/tmp/jenkins-server-container-id.txt; \
cat /tmp/jenkins-server-container-id.txt | xargs -I {} docker exec -i {} /bin/bash;
popd