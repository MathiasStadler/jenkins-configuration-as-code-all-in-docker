#!/bin/bash
set -o errexit -p posix -p unset

docker exec -it "$(cat /tmp/jenkins-server-container-id.txt)" "/bin/bash"

echo "EXIT docker container !!!"
