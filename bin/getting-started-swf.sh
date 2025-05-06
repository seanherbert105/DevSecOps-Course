#!/bin/bash

set -e

# Create Jenkins Docker network
docker network create jenkins

# Run Docker in Docker container
docker run \
  --name jenkins-docker \
  --rm \
  --detach \
  --privileged \
  --network jenkins \
  --network-alias docker \
  --env DOCKER_TLS_CERTDIR=/certs \
  --volume jenkins-docker-certs:/certs/client \
  --volume jenkins-data:/var/jenkins_home \
  --publish 2376:2376 \
  docker:dind \
  --storage-driver overlay2

# Build Jenkins container image with Docker
echo "Building Jenkins with Docker..."
docker buildx build -t jenkins/docker -f Dockerfile .

# Define container names and images
JENKINS_IMAGE="jenkins/docker"
TRIVY_IMAGE="aquasec/trivy"

# Run Jenkins container
echo "Starting Jenkins container..."
docker run \
  --name jenkins-blueocean \
  --restart=on-failure \
  --detach \
  --network jenkins \
  --env DOCKER_HOST=tcp://docker:2376 \
  --env DOCKER_CERT_PATH=/certs/client \
  --env DOCKER_TLS_VERIFY=1 \
  --publish 8080:8080 \
  --publish 50000:50000 \
  --volume jenkins-data:/var/jenkins_home \
  --volume jenkins-docker-certs:/certs/client:ro \
  --volume /var/run/docker.sock:/var/run/docker.sock \
  jenkins/docker

# Pull Trivy image
echo "Pulling Trivy image..."
docker pull $TRIVY_IMAGE

# Verify containers are running
echo "Checking running containers..."
docker ps --filter "name=jenkins"

echo "Setup complete. Access Jenkins at http://localhost:8080"
