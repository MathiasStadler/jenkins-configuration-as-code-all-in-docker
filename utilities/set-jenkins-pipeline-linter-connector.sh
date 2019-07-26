#!/bin/bash
# from https://jenkins.io/doc/book/pipeline/development/
set -o errexit -o posix -o pipefail -o nounset

JENKINS_USER="${JENKINS_USER:-admin}"
JENKINS_PASSWD="${JENKINS_PASSWD:-admin}"
JENKINS_HOST_NAME="${JENKINS_HOST_NAME:-localhost}"
JENKINS_HOST_PORT="${JENKINS_HOST_PORT:-8080}"
JENKINS_HOST_PROTOCOL="${JENKINS_HOST_PROTOCOL:-http}"

# "jenkins.pipeline.linter.connector.crumbUrl": "http://admin:admin@localhost:8080/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,%22:%22,//crumb))",
#     "jenkins.pipeline.linter.connector.user":"admin",
#     "jenkins.pipeline.linter.connector.pass": "admin",
#     "jenkins.pipeline.linter.connector.url":""

# curl (REST API)
# Assuming "anonymous read access" has been enabled on your Jenkins instance.
JENKINS_URL="${JENKINS_HOST_PROTOCOL}://${JENKINS_USER}:${JENKINS_PASSWD}@${JENKINS_HOST_NAME}:${JENKINS_HOST_PORT}"
# JENKINS_CRUMB is needed if your Jenkins master has CRSF protection enabled as it should
JENKINS_PIPELINE_LINTER_CONNECTOR_CRUMBURL="${JENKINS_URL}/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,\":\",//crumb)"
JENKINS_PIPELINE_LINTER_CONNECTOR_URL="${JENKINS_URL}/pipeline-model-converter/validate"
JENKINS_PIPELINE_LINTER_CONNECTOR_USER="${JENKINS_USER}"
JENKINS_PIPELINE_LINTER_CONNECTOR_PASS="${JENKINS_PASSWD}"

# write to /run
JENKINS_VALIDATE="/run/jenkins_validate"
sudo mkdir -pv "${JENKINS_VALIDATE}"

printf "%s\n" "${JENKINS_PIPELINE_LINTER_CONNECTOR_CRUMBURL}" | sudo tee "${JENKINS_VALIDATE}/${!JENKINS_PIPELINE_LINTER_CONNECTOR_CRUMBURL*}"
printf "%s\n" "${JENKINS_PIPELINE_LINTER_CONNECTOR_URL}" | sudo tee "${JENKINS_VALIDATE}/${!JENKINS_PIPELINE_LINTER_CONNECTOR_URL*}"
printf "%s\n" "${JENKINS_PIPELINE_LINTER_CONNECTOR_USER}" | sudo tee "${JENKINS_VALIDATE}/${!JENKINS_PIPELINE_LINTER_CONNECTOR_USER*}"
printf "%s\n" "${JENKINS_PIPELINE_LINTER_CONNECTOR_PASS}" | sudo tee "${JENKINS_VALIDATE}/${!JENKINS_PIPELINE_LINTER_CONNECTOR_PASS*}"

# set permissions

# found primary group
_GROUP=$(id -gn "${SUDO_USER:-$USER}")

sudo chown -R "${SUDO_USER:-$USER}:${_GROUP}" "${JENKINS_VALIDATE}"
sudo chmod -R 0400 "${JENKINS_VALIDATE}"

#  prepare project .vscode.settings.json
if [ -e .vscode ]; then

    if [ -e .vscode/settings.json ]; then
        echo "check is jenkins validator setting inside"
        if grep jenkins.pipeline.linter.connector.url .vscode/settings.json; then
            echo "ok"
        else
            echo "add to json file"
            TEMP_FILE=$(mktemp)

            cat <<EOF >"${TEMP_FILE}"
{
"jenkins.pipeline.linter.connector.crumbUrl":"${JENKINS_PIPELINE_LINTER_CONNECTOR_CRUMBURL}",
"jenkins.pipeline.linter.connector.url":"${JENKINS_PIPELINE_LINTER_CONNECTOR_URL}",
"jenkins.pipeline.linter.connector.user":"${JENKINS_PIPELINE_LINTER_CONNECTOR_USER}",
"jenkins.pipeline.linter.connector.pass":"${JENKINS_PIPELINE_LINTER_CONNECTOR_PASS}"
}
EOF
            cp .vscode/settings.json .vscode/settings.json_save_"$(date "+%Y%m%d")"
            jq add "${TEMP_FILE}" ".vscode/settings.json"
            # rm "${TEMP_FILE}"
        fi
    else
        printf "ERROR::No setting.json found "
    fi
else

    printf "ERROR: Please call the script from project home folder \n"
    printf " this folder %s not contains .vscode\n" "${0%/*}"
fi
