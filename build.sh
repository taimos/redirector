#!/usr/bin/env bash

VERSION=$(git rev-list --all --count)

docker build -t taimos/redirector:${VERSION} .

docker tag taimos/redirector:${VERSION} taimos/redirector:latest

#docker push taimos/redirector:${VERSION}
#docker push taimos/redirector:latest