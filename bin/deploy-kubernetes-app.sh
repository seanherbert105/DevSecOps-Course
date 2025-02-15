#!/bin/bash

# create Kubernetes namespace
kubectl create namespace geoserver

# deploy Kubernetes services
kubectl create -f ../kubernetes/pvc.yaml
kubectl create -f ../kubernetes/deployment.yaml
kubectl create -f ../kubernetes/service.yaml
kubectl create -f ../kubernetes/ingress.yaml
