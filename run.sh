#!/bin/bash

## resolve links - $0 may be a link to ant's home
PRG="$0"

# need this for relative symlinks
while [ -h "$PRG" ] ; do
  ls="$(ls -ld "$PRG")"
  link="$(expr "$ls" : '.*-> \(.*\)$')"
  if expr "$link" : '/.*' > /dev/null; then
    PRG="$link"
  else
    PRG="$(dirname "$PRG")/$link"
  fi
done

PROXY_ARGS="--env http_proxy=${http_proxy} \
            --env no_proxy=${no_proxy}"

WORK_DIR="$(dirname "$PRG")"
WORK_DIR="$(readlink -f ${WORK_DIR})/tmp"

mkdir -p ${WORK_DIR}
sync

GID="$(id -g)"

cd ${WORK_DIR}
docker run -v "$(pwd)/..":"$(pwd)/.." -e PUID=$(id -u) -e PGID=$(id -g) -ti --rm --workdir="$(pwd)" javister-docker-docker.bintray.io/javister/javister-docker-git:1.1 $@
