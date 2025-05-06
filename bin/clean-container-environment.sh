#!/bin/bash

set -e

echo "Stopping all running Docker containers..."
docker ps -q | xargs -r docker stop

echo "Removing all Docker containers..."
docker ps -aq | xargs -r docker rm

echo "Deleting all Kubernetes pods in all namespaces..."
kubectl delete pods --all --all-namespaces || true

echo "Deleting all Kubernetes services in all namespaces..."
kubectl delete svc --all --all-namespaces || true

echo "Cleanup complete: Docker containers and Kubernetes resources removed."