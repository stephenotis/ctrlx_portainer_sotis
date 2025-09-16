#!/bin/bash
TARGET_ARCH=$(dpkg --print-architecture)
if [[ -n $1 ]]; then
   TARGET_ARCH=$1
fi
echo TARGET_ARCH: ${TARGET_ARCH}

IMAGE_NAME="portainer/agent"
IMAGE_TAG="2.30.1"
DOCKER_CLI="/snap/bin/docker"

echo --- create ./docker-compose/docker-compose.env
rm -v -f ./docker-compose/docker-compose.env

echo IMAGE_NAME=${IMAGE_NAME} >> ./docker-compose/docker-compose.env
echo IMAGE_TAG=${IMAGE_TAG} >> ./docker-compose/docker-compose.env
echo EDGE_KEY= <insert here your server EDGE_KEY> >> ./docker-compose/docker-compose.env
echo EDGE_ID="1234567890" ./docker-compose/docker-compose.env #insert edge ID of choice

echo --- create docker image with platform ${TARGET_ARCH}
rm -f -v ./docker-compose/*.tar
${DOCKER_CLI} pull ${IMAGE_NAME}:${IMAGE_TAG} --platform ${TARGET_ARCH}
${DOCKER_CLI} save ${IMAGE_NAME}:${IMAGE_TAG} | gzip > ./docker-compose/image.tar.gz
${DOCKER_CLI} rmi ${IMAGE_NAME}:${IMAGE_TAG}
