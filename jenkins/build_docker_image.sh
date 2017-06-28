#!/bin/bash
function abort() {
  echo $@
  exit 1
}

GITHUB_TOKEN=${GITHUB_TOKEN:-$(git config --get github.token)}
KC_VERSION=${KC_VERSION:-$(curl -s -u :${GITHUB_TOKEN} "https://api.github.com/repos/dynport/kc/releases" | jq '.[0] | .tag_name' -c -r)}

set -e -o pipefail

if [[ -z $GITHUB_TOKEN ]]; then
    abort "GITHUB_TOKEN must be set"
fi

if [[ -z $KC_VERSION ]]; then
  abort "unable to get kc version"
fi

echo "using kc version ${KC_VERSION}"

VERSION=$(grep "FROM jenkinsci" Dockerfile |  cut -d ":" -f 2)
TAG=260336115275.dkr.ecr.eu-west-1.amazonaws.com/dynport/jenkins:${VERSION}-kc-${KC_VERSION}

function download_kc_release {
  if [[ -z $GITHUB_TOKEN ]]; then
    abort "github token must be present in .gitconfig"
  fi

  echo "downloading image with github token"
  url=$(curl -s -u :${GITHUB_TOKEN} https://api.github.com/repos/dynport/kc/releases | jq '.[0].assets[] | select(.name | contains("linux.amd64")) | .url' -c -r)

  if [[ -z $url ]]; then
    abort "unable to extract asset url"
  fi

  echo "downloading binary"
  curl -sL -H 'Accept: application/octet-stream' -u :${GITHUB_TOKEN} ${url} | tar xfz -
}

if [[ -z $VERSION ]]; then
  abort "unable to extract VERSION from Dockerfile"
fi

d=$(mktemp -d)
cp Dockerfile $d
pushd $d > /dev/null
trap "rm -Rf $d" EXIT

download_kc_release


echo "building ${TAG}"
docker build -t ${TAG} .
echo "built image ${TAG}"
env | grep SKIP
if [[ $SKIP_PUSH_IMAGE != "true" ]]; then
echo "pushing image ${TAG}"
docker push ${TAG}
echo "pushed image ${TAG}"
fi
