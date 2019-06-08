#!/bin/sh

TAG=`git rev-parse --short HEAD`

docker build -t andreleoni/inbox-microservice:$TAG .

IMAGE_ID=`docker images | grep andreleoni\/inbox-microservice | head -n1 | awk '{print $3}'`
docker tag $IMAGE_ID andreleoni/inbox-microservice:latest

docker push andreleoni/inbox-microservice:$TAG
docker push andreleoni/inbox-microservice:latest

cat kube/deployment.yaml | sed s/\$\$DOCKER_IMAGE/andreleoni\\/inbox-microservice:$TAG/g | kubectl apply -f -
