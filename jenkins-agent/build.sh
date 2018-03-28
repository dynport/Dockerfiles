#!/bin/bash
set -e -o pipefail

export GITHUB_TOKEN=$(kubectl get secrets/build-github-token -o json  | jq '.data.token' -c -r | base64 -d)
export GCLOUD_VERSION=194.0.0
export KC_VERSION=v28
export IMAGE=eu.gcr.io/build-140318/jenkins-agent:${GCLOUD_VERSION}-${KC_VERSION}

if [[ -z $GITHUB_TOKEN ]]; then
  echo "unable to find GITHUB_TOKEN"
  exit 1
fi


DOWNLOAD_URL=$(curl -SsfL -u :${GITHUB_TOKEN} https://api.github.com/repos/dynport/kc/releases | jq '.[] | .assets[] | select(.name == "kc.'${KC_VERSION}'.linux.amd64.tgz") | .url'  -c -r)

curl -s -H 'Accept: application/octet-stream' -u :${GITHUB_TOKEN} -L ${DOWNLOAD_URL} | tar xfz -
echo "downloaded kc"
trap "rm -f kc" EXIT

gcloud container builds submit --substitutions=_GCLOUD_VERSION=${GCLOUD_VERSION},_GITHUB_TOKEN=${GITHUB_TOKEN},_IMAGE=${IMAGE} --config build.yml .
echo "pushed ${IMAGE}"
