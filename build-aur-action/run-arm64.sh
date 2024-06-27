#!/bin/bash

set -eo pipefail

sudo apt update -y && sudo apt install -y qemu qemu-user-static

ACT_PATH=$(dirname $(dirname $(readlink -fm "$0")))

docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
docker build . --file $ACT_PATH/build-aur-action/Dockerfile --tag multiarchimage

docker run \
  --workdir /github/workspace \
  --rm \
  -e HOME=/github/home \
  -e GITHUB_REF \
  -e GITHUB_SHA \
  -e GITHUB_REPOSITORY \
  -e GITHUB_ACTOR \
  -e GITHUB_WORKFLOW=/github/workflow \
  -e GITHUB_HEAD_REF \
  -e GITHUB_BASE_REF \
  -e GITHUB_EVENT_NAME \
  -e GITHUB_WORKSPACE=/github/workspace \
  -e GITHUB_ACTION \
  -e GITHUB_EVENT_PATH \
  -e RUNNER_OS \
  -e RUNNER_TOOL_CACHE \
  -e RUNNER_TEMP \
  -e RUNNER_WORKSPACE \
  -v "/var/run/docker.sock":"/var/run/docker.sock" \
  -v "/home/runner/work/_temp/_github_home":"/github/home" \
  -v "/home/runner/work/_temp/_github_workflow":"/github/workflow" \
  -v "${PWD}":"/github/workspace" \
  -t multiarchimage \
  /bin/bash -c /entrypoint.sh $@
