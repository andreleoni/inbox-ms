# !/bin/bash

set -e

echo "Deploying to ${DEPLOYMENT_ENVIRONMENT}"

echo $ACCOUNT_KEY_STAGING > service_key.txt

base64 service_key.txt -d > ${HOME}/gcloud-service-key.json

gcloud auth activate-service-account ${ACCOUNT_ID} --key-file ${HOME}/gcloud-service-key.json

gcloud config set project microserviceevaluation

gcloud config set compute/zone us-central1-a

gcloud --quiet config set container/cluster microservices

gcloud --quiet container clusters get-credentials microservices

IMAGE_ID=`docker images | grep andreleoni\/inbox-microservice | head -n1 | awk '{print $3}'`

docker build -t andreleoni/inbox-microservice:$IMAGE_ID .

docker build -t microservices/${PROJECT_ID}/${REG_ID}:$CIRCLE_SHA1 .

gcloud docker -- push microservices/${PROJECT_ID}/${REG_ID}:$CIRCLE_SHA1

kubectl set image deployment/${DEPLOYMENT_NAME} ${CONTAINER_NAME}=microservices/${PROJECT_ID}/${REG_ID}:$CIRCLE_SHA1

echo " Successfully deployed to production"
