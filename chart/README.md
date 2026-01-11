# Getting Started with Kubernetes

This repository contains Kubernetes-related resources and examples.

This guide is intended for **individuals who are new to Kubernetes** and need a practical introduction to:
- What Kubernetes is
- How to interact with a cluster
- Common Kubernetes objects
- Frequently used `kubectl` commands
- How to safely explore a cluster without breaking anything

---

## What Is Kubernetes?

Kubernetes (often abbreviated as **K8s**) is a **container orchestration platform** used to:
- Run containerized applications (Docker containers)
- Automatically handle scaling and availability
- Restart failed applications
- Manage networking and service discovery
- Declaratively define system state using YAML files

Instead of managing individual servers, Kubernetes lets you manage **applications at scale**.

---

## Core Kubernetes Concepts (Beginner Friendly)

### Cluster
A **Kubernetes cluster** is a group of machines that run your applications.

It consists of:
- **Control Plane** – manages the cluster
- **Worker Nodes** – run application workloads

---

### Namespace
A **namespace** is a logical grouping of resources.

Why namespaces matter:
- Separate environments (dev, test, prod)
- Reduce naming conflicts
- Improve access control

Example namespaces:
- `default`
- `kube-system`
- `monitoring`

---

### Pod
A **Pod** is the smallest deployable unit in Kubernetes.

Key points:
- A pod runs one or more containers
- Pods are ephemeral (they can be destroyed and recreated)
- You usually don’t create pods directly

---

### Deployment
A **Deployment**:
- Manages pods for you
- Handles rolling updates
- Restarts failed pods automatically

Deployments are the **most common workload type**.

---

### Service
A **Service**:
- Exposes pods internally or externally
- Provides stable networking
- Load-balances traffic between pods

---

### Ingress / Gateway
Ingress and Gateway APIs:
- Expose services to external users
- Provide routing and TLS
- Act as the “entry point” to your cluster

---

## Official Kubernetes Documentation

### Kubernetes Docs
https://kubernetes.io/

Use this for:
- Core Kubernetes concepts
- API reference
- Architecture explanations
- Official best practices

---

## Installing kubectl

`kubectl` is the **command-line tool** used to interact with Kubernetes.

Installation instructions:
https://kubernetes.io/docs/tasks/tools/

Verify installation:
```
kubectl version --client
```

### Command Shortcuts

Get Kubernetes services in all namespaces
```
kubectl get service --all-namespaces
```

Get Kubernetes pods in all namespaces
```
kubectl get pods --all-namespaces
```

Get Kubernetes deployments in all namespaces
```
kubectl get deployments --all-namespaces
```

Get Kubernetes statefulsets in all namespaces
```
kubectl get statefulsets --all-namespaces
```

Get Kubernetes ingress in all namespaces
```
kubectl get ingress --all-namespaces
```

Get all Kubernetes resources in all namespaces
```
kubectl get all --all-namespaces
```