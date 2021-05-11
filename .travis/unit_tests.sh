#!/bin/bash

set +e

CGO_ENABLED=0 GOOS=linux go build -mod=vendor -a -ldflags '-w -s' -a -installsuffix cgo -o che-machine-exec .
export CHE_WORKSPACE_ID=test_id
go test ./... -test.v

docker build -f build/dockerfiles/Dockerfile -t quay.io/prabhav/che-machine-exec:pr-check-"${TRAVIS_CPU_ARCH}" . 
