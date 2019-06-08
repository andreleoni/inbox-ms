#!/bin/bash

# Make sure we have gcloud installed in travis env
if [ ! -d "$HOME/google-cloud-sdk/bin" ]; then
  rm -rf "$HOME/google-cloud-sdk"
  curl https://sdk.cloud.google.com | bash > /dev/null
fi

# Promote gcloud to PATH top priority (prevent using old version fromt travis)
source $HOME/google-cloud-sdk/path.bash.inc

# Make sure kubectl is updated to latest version
gcloud components update kubectl

TAG=`git rev-parse --short HEAD`

echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin=

docker build -t andreleoni/inbox-microservice:$TAG .

IMAGE_ID=`docker images | grep andreleoni\/inbox-microservice | head -n1 | awk '{print $3}'`
docker tag $IMAGE_ID andreleoni/inbox-microservice:latest

docker push andreleoni/inbox-microservice:$TAG
docker push andreleoni/inbox-microservice:latest

cat kube/deployment.yaml | sed s/\$\$DOCKER_IMAGE/andreleoni\\/inbox-microservice:$TAG/g | kubectl apply -f -
