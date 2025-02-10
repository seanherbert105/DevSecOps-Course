#!/bin/bash

set -e

echo "Stopping all running containers..."
docker ps -q | xargs -r docker stop

echo "Removing all containers..."
docker ps -aq | xargs -r docker rm

echo "All containers have been stopped and removed."
