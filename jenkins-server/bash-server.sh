#!/bin/bash
set -o errexit -o posix -o unset

docker exec -it "$(cat /tmp/jenkins-server-container-id.txt)" "/bin/bash"

echo "EXIT docker container !!!"
