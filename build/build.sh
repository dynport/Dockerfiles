#!/bin/bash
set -e

cp $GOPATH/src/github.com/dynport/dpx/cmd/build-cleanup/cleanup_build_server.sh ./
docker build . -t 260336115275.dkr.ecr.eu-west-1.amazonaws.com/dynport/build

rm cleanup_build_server.sh
