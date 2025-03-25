#!/bin/bash

set -e

# Build Jenkins container image with Docker
echo "Building Jenkins with Docker..."
docker buildx build -t jenkins/docker:latest -f Dockerfile.jenkins .

# Define container names and images
JENKINS_IMAGE="jenkins/docker:latest"
TRIVY_IMAGE="aquasec/trivy"

# Pull Jenkins image
echo "Pulling Jenkins image..."
docker pull $JENKINS_IMAGE

# Run Jenkins container
echo "Starting Jenkins container..."
docker run -d --name jenkins -p 8080:8080 -p 50000:50000 \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v jenkins_home:/var/jenkins_home \
    --restart unless-stopped $JENKINS_IMAGE

# Pull Trivy image
echo "Pulling Trivy image..."
docker pull $TRIVY_IMAGE

# Verify containers are running
echo "Checking running containers..."
docker ps --filter "name=jenkins"

echo "Setup complete. Access Jenkins at http://localhost:8080"
