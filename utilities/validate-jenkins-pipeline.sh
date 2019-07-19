#!/bin/bash
# from https://jenkins.io/doc/book/pipeline/development/
set -o errexit -o posix -o pipefail -o nounset

if [ "$#" -eq 1 ]; then

    # curl (REST API)
    # Assuming "anonymous read access" has been enabled on your Jenkins instance.
    JENKINS_URL="http://admin:admin@localhost:8080"
    # JENKINS_CRUMB is needed if your Jenkins master has CRSF protection enabled as it should
    JENKINS_CRUMB=$(curl "$JENKINS_URL/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,\":\",//crumb)")
    echo "JENKINS_CRUMB => ${JENKINS_CRUMB}";
    curl -X POST -H $JENKINS_CRUMB -F "jenkinsfile=<$1" $JENKINS_URL/pipeline-model-converter/validate

elif [ "$#" -gt 1 ]; then

    printf "ERROR:: only one file expected, no folder\n"
    exit 1

else

    printf "Oops no JENKINSFILE path found\n"
fi
