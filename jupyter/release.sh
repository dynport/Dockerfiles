#!/bin/bash
set -e -o pipefail

export AWS_CREDENTIALS_PATH=$HOME/.phrase/config.json

IMAGE=260336115275.dkr.ecr.eu-west-1.amazonaws.com/phrase/jupyter:latest

docker build -t  ${IMAGE} .

eval $(aws-mfa ecr get-login --no-include-email)

docker push ${IMAGE}
