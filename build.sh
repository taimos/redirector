#!/usr/bin/env bash

set -e

VERSION=$(git rev-list --all --count)

echo "Building version ${VERSION}"

docker pull nginx:stable-alpine

docker build -t taimos/redirector:${VERSION} .

CONTAINER=$(docker run -d -P taimos/redirector:${VERSION})

PORT=$(docker inspect -f '{{ (index (index .NetworkSettings.Ports "80/tcp") 0).HostPort }}' ${CONTAINER})

./test.sh ${PORT}

docker stop ${CONTAINER}
docker rm ${CONTAINER}

docker tag taimos/redirector:${VERSION} taimos/redirector:latest

docker push taimos/redirector:${VERSION}
docker push taimos/redirector:latest