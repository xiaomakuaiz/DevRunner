#!/usr/bin/env bash
set -euo pipefail

# Simple builder for DevRunner images.
# Usage:
#   STACK=base VERSION=bookworm REGISTRY=ghcr.io/chaitin/monkeycode-runner PUSH=false ./scripts/build.sh

STACK=${STACK:-base}
VERSION=${VERSION:-bookworm}
REGISTRY=${REGISTRY:-ghcr.io/chaitin/monkeycode-runner}
PUSH=${PUSH:-false}

if [[ "${STACK}" == "base" ]]; then
  DOCKERFILE="docker/base/${VERSION}/Dockerfile"
else
  DOCKERFILE="docker/${STACK}/${VERSION}/Dockerfile"
fi

if [[ ! -f "${DOCKERFILE}" ]]; then
  echo "Dockerfile not found: ${DOCKERFILE}" >&2
  exit 1
fi

IMAGE="$(echo "${REGISTRY}" | tr '[:upper:]' '[:lower:]')/${STACK}:${VERSION}"
echo "Building ${IMAGE} with ${DOCKERFILE}"
docker build -f "${DOCKERFILE}" -t "${IMAGE}" .

if [[ "${PUSH}" == "true" ]]; then
  echo "Pushing ${IMAGE}"
  docker push "${IMAGE}"
fi
