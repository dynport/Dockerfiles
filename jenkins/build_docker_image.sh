#!/bin/bash
set -e -o pipefail

KC_VERSION=v19
VERSION=$(grep "FROM jenkinsci" Dockerfile |  cut -d ":" -f 2)
TAG=260336115275.dkr.ecr.eu-west-1.amazonaws.com/dynport/jenkins:${VERSION}-kc-${KC_VERSION}

function abort() {
  echo $@
  exit 1
}

function download_kc_release {
  token=$(git config --global --get github.token)
  if [[ -z $token ]]; then
    abort "github token must be present in .gitconfig"
  fi

  url=$(curl -s -u :${token} https://api.github.com/repos/dynport/kc/releases | jq '.[0].assets[] | select(.name | contains("linux.amd64")) | .url' -c -r)

  if [[ -z $url ]]; then
    abort "unable to extract asset url"
  fi

  curl -sL -H 'Accept: application/octet-stream' -u :${token} ${url} | tar xfz -
}

if [[ -z $VERSION ]]; then
  abort "unable to extract VERSION from Dockerfile"
fi

d=$(mktemp -d)
cp Dockerfile $d
pushd $d > /dev/null
trap "rm -Rf $d" EXIT

download_kc_release


echo building ${TAG}
docker build -t ${TAG} .
docker push ${TAG}
echo built ${TAG}
