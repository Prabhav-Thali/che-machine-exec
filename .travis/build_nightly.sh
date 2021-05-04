#!/bin/bash

echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
echo "$QUAY_PASSWORD" |docker login quay.io -u "$QUAY_USERNAME " --password-stdin
docker build -f build/dockerfiles/Dockerfile -t quay.io/prabhav/che-machine-exec:nightly-"${TRAVIS_CPU_ARCH}" .
echo "${SHORT_SHA}"
docker tag quay.io/prabhav/che-machine-exec:nightly-"${TRAVIS_CPU_ARCH}" quay.io/prabhav/che-machine-exec:"${SHORT_SHA}"-"${TRAVIS_CPU_ARCH}"
docker push quay.io/prabhav/che-machine-exec:nightly-"${TRAVIS_CPU_ARCH}"
docker push quay.io/prabhav/che-machine-exec:"${SHORT_SHA}"-"${TRAVIS_CPU_ARCH}"