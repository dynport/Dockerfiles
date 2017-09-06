#!/bin/bash
set -e -o pipefail

cmd="java -jar ./swarm-client.jar"

if [[ -n $JENKINS_USER ]]; then
  cmd="${cmd} -username ${JENKINS_USER}"
fi

if [[ -n $JENKINS_PASSWORD ]]; then
  cmd="${cmd} -password ${JENKINS_PASSWORD}"
fi

if [[ -n $JENKINS_MASTER ]]; then
  cmd="${cmd} -master ${JENKINS_MASTER}"
fi

set -x
exec $cmd
