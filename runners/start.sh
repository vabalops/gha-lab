#!/bin/bash

REPOSITORY=$REPO
ACCESS_TOKEN=$TOKEN

# To generate more unique runner names when launching multiple instances
S=$((1 + RANDOM % 5))
echo "Sleeping for $S seconds..."
sleep "$S"

RUNNER_NAME="runner-$(date +"%Y%m%d%H%M%S")-${RANDOM}"

echo "Running as $(whoami)"
echo "REPO ${REPOSITORY}"
echo "Runner ${RUNNER_NAME}"

REG_TOKEN=$(curl -X POST -H "Authorization: token ${ACCESS_TOKEN}" -H "Accept: application/vnd.github+json" https://api.github.com/repos/${REPOSITORY}/actions/runners/registration-token | jq .token --raw-output)

cd /home/runner

./config.sh --url https://github.com/${REPOSITORY} --unattended --token ${REG_TOKEN} --replace --name $RUNNER_NAME

cleanup() {
    echo "Removing runner..."
    ./config.sh remove --token ${REG_TOKEN}
}

trap 'cleanup; exit 130' INT
trap 'cleanup; exit 143' TERM

./run.sh & wait $!
