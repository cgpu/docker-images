#!/bin/bash

set -eu

if [[ -f secrets ]]; then
  . secrets
fi

DOCKER_IMAGE=aaronhopkinson/n102-jupyterlab-amber_nn:latest
LOCAL_MOUNT=${PWD}/mount

NAME=$(git config --global --get user.name)
EMAIL=$(git config --global --get user.email)

if [[ -z ${NAME:-} ]] || [[ -z ${EMAIL:-} ]]; then
  echo "Set your git username and email with"
  echo '    git config --global user.name "Your Name"'
  echo '    git config --global user.email "your.name@email.com"'
  echo "and re-run this script"
  exit 1
fi

docker pull $DOCKER_IMAGE
docker run \
  -e NAME="$NAME" \
  -e EMAIL="$EMAIL" \
  -e GITHUB_TOKEN="${GITHUB_TOKEN:-}" \
  -p 8888:8888 \
  -v $LOCAL_MOUNT:/home/jovyan/work \
  --rm \
  $DOCKER_IMAGE
