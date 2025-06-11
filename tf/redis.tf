resource "kubernetes_stateful_set_v1" "redis" {
  metadata {
    name = "redis"

    annotations = {
      SomeAnnotation = "foobar"
    }

    labels = {
      k8s-app                           = "redis"
      kubernetes_io_cluster_service     = "true"
      addonmanager_kubernetes_io_mode   = "Reconcile"
      version                           = "v1.0.0"
    }
  }

  spec {
    service_name = "redis-service"
    replicas     = 1

    selector {
      match_labels = {
        k8s-app = "redis"
      }
    }

    template {
      metadata {
        labels = {
          k8s-app = "redis"
        }

        annotations = {}
      }

      spec {
        container {
          name  = "redis"
          image = "redis:alpine"
          image_pull_policy = "IfNotPresent"

          port {
            container_port = 6379
          }

          resources {
            limits = {
              cpu    = "10m"
              memory = "10Mi"
            }

            requests = {
              cpu    = "10m"
              memory = "10Mi"
            }
          }

          volume_mount {
            name       = "redis-data"
            mount_path = "/data"
          }
        }
      }
    }

    volume_claim_template {
      metadata {
        name = "redis-data"
      }

      spec {
        access_modes = ["ReadWriteOnce"]

        resources {
          requests = {
            storage = "1Gi"
          }
        }
      }
    }
  }
}