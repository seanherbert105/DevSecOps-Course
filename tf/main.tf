terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.36.0"
    }
  }
}

provider "kubernetes" {
  # This should be the default location where Docker Desktop stores your Kubernetes configuration.
  # Please change to fit your exisiting Kubernetes configuration.
  config_path = "~/.kube/config"
}