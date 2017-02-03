#!/bin/bash
set -e -o pipefail

pushd ./

cd $GOPATH/src/github.com/dynport/kc && make
popd
cp $GOPATH/bin/kc ./

docker build -t phraseapp/jenkins:$1 . && docker push phraseapp/jenkins:$1

rm -f ./kc
