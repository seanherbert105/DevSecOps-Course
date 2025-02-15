#!/bin/bash

# delete Kubernetes services
kubectl delete -f ../kubernetes/deployment.yaml
kubectl delete -f ../kubernetes/service.yaml
kubectl delete -f ../kubernetes/ingress.yaml
kubectl delete -f ../kubernetes/pvc.yaml

# delete Kubernetes namespace
kubectl delete namespaces geoserver
