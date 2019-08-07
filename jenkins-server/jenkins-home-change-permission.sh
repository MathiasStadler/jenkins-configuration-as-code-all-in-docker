#!/bin/bash

set -o errexit -o posix -o nounset -o pipefail

chown -R jenkins:jenkins  "${JENKINS_HOME:-}/workspace"
