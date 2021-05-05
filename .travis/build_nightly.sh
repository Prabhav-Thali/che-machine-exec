#!/bin/bash

TAG=$1

docker build -f build/dockerfiles/Dockerfile -t quay.io/prabhav/che-machine-exec:"$TAG"-"${TRAVIS_CPU_ARCH}" .
docker push quay.io/prabhav/che-machine-exec:"$TAG"-"${TRAVIS_CPU_ARCH}"

if [[ "$TAG" == "nightly" ]]; then
    docker tag quay.io/prabhav/che-machine-exec:"$TAG"-"${TRAVIS_CPU_ARCH}" quay.io/prabhav/che-machine-exec:"${SHORT_SHA}"-"${TRAVIS_CPU_ARCH}"
    docker push quay.io/prabhav/che-machine-exec:"${SHORT_SHA}"-"${TRAVIS_CPU_ARCH}"
fi