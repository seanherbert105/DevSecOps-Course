resource "kubernetes_deployment_v1" "result" {
  metadata {
    name = "result"
    labels = {
      test = "result"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        test = "result"
      }
    }

    template {
      metadata {
        labels = {
          test = "result"
        }
      }

      spec {
        image_pull_secrets {
          name = kubernetes_secret_v1.github_registry.metadata[0].name
        }

        container {
          image = "seanherbert105/devsecops-course/voting-app/result:main"
          name  = "result"

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