#!/bin/bash -e

# DOCKER_IMAGE=$1
# IDENTITY_ID=$2
# ACR_NAME=$3

DOCKER_IMAGE="${container_image}"
IDENTITY_ID="${identity_id}"
SERVICE_NAME="${vm_name}"

curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

echo "Provisioning docker image $DOCKER_IMAGE"

# cleanup previous deployment
sudo docker stop newsfeed || true
sudo docker rm newsfeed || true
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
sudo az login --identity

sudo az acr login --name $ACR_NAME

sudo docker pull $DOCKER_IMAGE

sudo docker run -d \
  --name newsfeed \
  --restart always \
  -p 8081:8081 \
  $DOCKER_IMAGE
