resource "kubernetes_deployment" "worker" {
  metadata {
    name = "worker"
    labels = {
      test = "worker"
    }
  }

  spec {
    replicas = 1

    image_pull_secrets {
      name = kubernetes_secret.github_registry.metadata[0].name
    }

    selector {
      match_labels = {
        test = "worker"
      }
    }

    template {
      metadata {
        labels = {
          test = "worker"
        }
      }

      spec {
        container {
          image = "seanherbert105/devsecops-course/voting-app/worker:main"
          name  = "worker"

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}