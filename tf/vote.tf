resource "kubernetes_deployment" "vote" {
  metadata {
    name = "vote"
    labels = {
      test = "vote"
    }
  }

  spec {
    replicas = 1

    image_pull_secrets {
      name = kubernetes_secret.github_registry.metadata[0].name
    }

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