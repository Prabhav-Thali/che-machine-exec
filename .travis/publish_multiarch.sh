#!/bin/bash

TAG=$1

AMEND=""
AMEND+=" --amend quay.io/prabhav/che-machine-exec:$TAG-amd64";
AMEND+=" --amend quay.io/prabhav/che-machine-exec:$TAG-arm64";
AMEND+=" --amend quay.io/prabhav/che-machine-exec:$TAG-ppc64le";
AMEND+=" --amend quay.io/prabhav/che-machine-exec:$TAG-s390x";

echo $AMEND
echo $TAG

docker manifest create quay.io/prabhav/che-machine-exec:"${TAG}" "${AMEND}"
docker manifest push quay.io/prabhav/che-machine-exec:"${TAG}"

if [[ "$TAG" == "nightly" ]]; then
    docker manifest create quay.io/prabhav/che-machine-exec:"${SHORT_SHA}" "${AMEND}"
    docker manifest push quay.io/prabhav/che-machine-exec:"${SHORT_SHA}"
fi