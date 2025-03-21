#!/bin/bash -e

DOCKER_IMAGE=$1
IDENTITY_ID=$2
ACR_NAME=$3

curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

echo "Provisioning docker image $DOCKER_IMAGE"

# cleanup previous deployment
sudo docker stop newsfeed || true
sudo docker rm newsfeed || true

sudo az login --identity --username $IDENTITY_ID

sudo az acr login --name $ACR_NAME

sudo docker pull $DOCKER_IMAGE

sudo docker run -d \
  --name newsfeed \
  --restart always \
  -p 8081:8081 \
  $DOCKER_IMAGE
