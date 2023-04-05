# Build the example project docker image

## image name
IMAGE_NAME=example

## image version
IMAGE_VERSION=1.0.0

## build image
docker build -t ${IMAGE_NAME}:${IMAGE_VERSION} .