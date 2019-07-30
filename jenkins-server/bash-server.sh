#!/bin/bash
set -o errexit -o posix -o pipefail -o nounset

docker exec -it "$(cat /tmp/jenkins-server-container-id.txt)" "/bin/bash"

echo "EXIT docker container !!!"
