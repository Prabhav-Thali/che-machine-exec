#!/bin/bash

AMEND=""
# if [ -n "$AMD64_VERSION" ]; then
#     AMEND+=" --amend quay.io/prabhav/che-machine-exec:$AMD64_VERSION";
# fi
#
# if [ -n "$ARM64_VERSION" ]; then
#     AMEND+=" --amend quay.io/prabhav/che-machine-exec:$ARM64_VERSION";
# fi
#
# if [ -n "$PPC64LE_VERSION" ]; then
#     AMEND+=" --amend quay.io/prabhav/che-machine-exec:$PPC64LE_VERSION";
# fi

# if [ -n "$S390X_VERSION" ]; then
#     AMEND+=" --amend quay.io/prabhav/che-machine-exec:$S390X_VERSION";
# fi

# if [ -z "$AMEND" ]; then
#     echo "[!] The stage 'building-images' didn't provide any outputs. Can't create the manifest list."
#     exit 1;
# fi

AMEND+=" --amend quay.io/prabhav/che-machine-exec:nightly-amd64";
AMEND+=" --amend quay.io/prabhav/che-machine-exec:nightly-arm64";
AMEND+=" --amend quay.io/prabhav/che-machine-exec:nightly-ppc64le";
AMEND+=" --amend quay.io/prabhav/che-machine-exec:nightly-s390x";

docker manifest create quay.io/prabhav/che-machine-exec:nightly $AMEND
docker manifest push quay.io/prabhav/che-machine-exec:nightly
docker manifest create quay.io/prabhav/che-machine-exec:"${SHORT_SHA}" $AMEND
docker manifest push quay.io/prabhav/che-machine-exec:"${SHORT_SHA}"