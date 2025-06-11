resource "kubernetes_stateful_set_v1" "db" {
  metadata {
    name = "db"

    annotations = {
      SomeAnnotation = "foobar"
    }

    labels = {
      k8s-app                          = "db"
      kubernetes_io_cluster_service    = "true"
      addonmanager_kubernetes_io_mode  = "Reconcile"
      version                          = "v1.0.0"
    }
  }

  spec {
    service_name = "db-service"
    replicas     = 1

    selector {
      match_labels = {
        k8s-app = "db"
      }
    }

    template {
      metadata {
        labels = {
          k8s-app = "db"
        }

        annotations = {}
      }

      spec {
        container {
          name  = "db"
          image = "postgres:15-alpine"
          image_pull_policy = "IfNotPresent"

          port {
            container_port = 5432
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
            name       = "db-config"
            mount_path = "/etc/db-config"
            read_only  = true
          }

          volume_mount {
            name       = "db-data"
            mount_path = "/var/lib/postgresql/data"
          }

          env_from {
            config_map_ref {
              name = kubernetes_config_map_v1_data.db-config.metadata[0].name
            }
          }
        }

        volume {
          name = "db-config"

          config_map {
            name = kubernetes_config_map_v1_data.db-config.metadata[0].name
          }
        }
      }
    }

    volume_claim_template {
      metadata {
        name = "db-data"
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
