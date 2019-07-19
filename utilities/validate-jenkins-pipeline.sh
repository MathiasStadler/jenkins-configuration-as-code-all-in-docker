#!/bin/bash
# from https://jenkins.io/doc/book/pipeline/development/
set -o errexit -o posix -o pipefail -o nounset

curl --version >/dev/null 2>/dev/null || { printf "curl needed, install first\n"; exit 1;}

JENKINS_USER="${JENKINS_USER:-admin}";
JENKINS_PASSWD="${JENKINS_PASSWD:-admin}";
JENKINS_HOST_NAME="${JENKINS_HOST_NAME:-localhost}";
JENKINS_HOST_PORT="${JENKINS_HOST_PORT:-8080}";
JENKINS_HOST_PROTOCOL="${JENKINS_HOST_PROTOCOL:-http}";

if [ "$#" -eq 1 ]; then

    # curl (REST API)
    # Assuming "anonymous read access" has been enabled on your Jenkins instance.
    JENKINS_URL="${JENKINS_HOST_PROTOCOL}://${JENKINS_USER}:${JENKINS_PASSWD}@${JENKINS_HOST_NAME}:${JENKINS_HOST_PORT}";
    # JENKINS_CRUMB is needed if your Jenkins master has CRSF protection enabled as it should
    JENKINS_CRUMB=$(curl "$JENKINS_URL/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,\":\",//crumb)")
    curl -X POST -H "${JENKINS_CRUMB}" -F "jenkinsfile=<${1}" "${JENKINS_URL}"/pipeline-model-converter/validate

elif [ "$#" -gt 1 ]; then

    printf "ERROR:: only one file expected, no folder\n"
    exit 1

else

    printf "Oops no JENKINSFILE path found\n"
fi
