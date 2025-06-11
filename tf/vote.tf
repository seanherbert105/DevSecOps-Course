resource "kubernetes_deployment_v1" "vote" {
  metadata {
    name = "vote"
    labels = {
      test = "vote"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        test = "vote"
      }
    }

    template {
      metadata {
        labels = {
          test = "vote"
        }
      }

      spec {
        image_pull_secrets {
          name = kubernetes_secret_v1.github_registry.metadata[0].name
        }

        container {
          image = "seanherbert105/devsecops-course/voting-app/vote:main"
          name  = "vote"

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