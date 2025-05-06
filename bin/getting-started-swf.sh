#!/bin/bash

set -e

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

echo "🚀 Starting Helm, Traefik, and ArgoCD setup..."

# Install Helm if not installed
if ! command_exists helm; then
  echo "🔧 Helm not found. Installing..."
  curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
else
  echo "✅ Helm is already installed."
fi

# Create namespace for Traefik
echo "📦 Installing Traefik Ingress Controller..."
kubectl create namespace traefik --dry-run=client -o yaml | kubectl apply -f -

helm repo add traefik https://traefik.github.io/charts
helm repo update

helm upgrade --install traefik traefik/traefik \
  --namespace traefik \
  --set ingressClass.enabled=true \
  --set ingressClass.isDefaultClass=true \
  --set service.type=LoadBalancer \
  --set dashboard.enabled=true \
  --set ports.websecure.expose=true

# Expose Traefik dashboard via IngressRoute
cat <<EOF | kubectl apply -f -
apiVersion: traefik.containo.us/v1alpha1
kind: IngressRoute
metadata:
  name: traefik-dashboard
  namespace: traefik
spec:
  entryPoints:
    - web
  routes:
    - match: Host(\`traefik.localhost\`)
      kind: Rule
      services:
        - name: api@internal
          kind: TraefikService
EOF

# Create namespace for ArgoCD
echo "📦 Installing ArgoCD..."
kubectl create namespace argocd --dry-run=client -o yaml | kubectl apply -f -

helm repo add argo https://argoproj.github.io/argo-helm
helm repo update

helm upgrade --install argocd argo/argo-cd \
  --namespace argocd \
  --set server.service.type=LoadBalancer

echo "✅ Installation complete!"

echo -e "\n🔑 To get the ArgoCD admin password, run:"
echo "kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath=\"{.data.password}\" | base64 -d && echo"

echo -e "\n🌐 Access UIs:"
echo "➡️ Traefik Dashboard: http://traefik.localhost (set this in /etc/hosts as 127.0.0.1 traefik.localhost)"
echo "➡️ ArgoCD UI: http://localhost:<ARGOCD_PORT>  (check with: kubectl -n argocd get svc argocd-server)"
