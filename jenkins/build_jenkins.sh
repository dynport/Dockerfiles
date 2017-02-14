#!/bin/bash
set -e -o pipefail

VERSION=$(grep "FROM jenkinsci" Dockerfile |  cut -d ":" -f 2)

if [[ -z $VERSION ]]; then
  echo "unable to extract VERSION from Dockerfile"
  exit 1
fi

d=$(mktemp -d)
cp Dockerfile $d
pushd $d
trap "rm -Rf $d" EXIT

go build -o kc github.com/dynport/kc

TAG=260336115275.dkr.ecr.eu-west-1.amazonaws.com/dynport/jenkins:${VERSION}

docker build -t ${TAG} .
docker push ${TAG}
