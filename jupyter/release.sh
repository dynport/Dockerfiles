#!/bin/bash
set -e -o pipefail

export AWS_CREDENTIALS_PATH=$HOME/.phrase/config.json

base_dir=$(git rev-parse --show-toplevel)

function git_revision {
  git rev-parse HEAD | cut -b 1-${REV_LEN}
}

function changed_revision {
  changed=$(git status --untracked-files=all --porcelain . | awk '{ print $2 }' | sort)
  if [[ -n $changed ]]; then
    cat ${base_dir}/${changed} | md5sum | cut -b 1-${REV_LEN} | awk '{ print $1 }'
  fi
}

function short_ref {
  echo $1 | cut -b 1-7
}

function full_revision {
  rev=$(short_ref $(git_revision))
  changed=$(changed_revision)
  if [[ -n $changed ]]; then
    rev=${rev}-$(short_ref $changed)
  fi
  echo ${rev}
}

IMAGE=260336115275.dkr.ecr.eu-west-1.amazonaws.com/phrase/jupyter:$(full_revision)
echo "building image ${IMAGE}"

docker build -t  ${IMAGE} .

eval $(aws-mfa ecr get-login --no-include-email)

docker push ${IMAGE}

echo "pushed ${IMAGE}"
