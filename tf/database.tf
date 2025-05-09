resource "kubernetes_stateful_set_v1" "db" {
  metadata {
    name = "db"

    annotations = {
      SomeAnnotation = "foobar"
    }

    labels = {
      k8s-app                            = "db"
      "kubernetes.io/cluster-service"    = "true"
      "addonmanager.kubernetes.io/mode"  = "Reconcile"
      version                            = "v1.0.0"
    }
  }

  spec {
    service_name="db-service"
    replicas=1

    selector {
      match_labels = {
        k8s-app="db"
      }
    }

    template {
      metadata {
        labels = {
          k8s-app="db"
        }

        annotations = {}
      }

      spec {
        container {
          name="db"
          image="postgres:15-alpine"
          image_pull_policy="IfNotPresent"

          volume_mount {
            name="db-config"
            mount_path="/etc/db-config"
            read_only=true
          }

          resources {
            limits = {
              cpu="10m"
              memory="10Mi"
            }

            requests = {
              cpu="10m"
              memory="10Mi"
            }
          }

          port {
            container_port=5432
          }
        }

        volume {
          name="db-config"

          config_map {
            name="db-config" # Reference to your external ConfigMap
          }
        }
      }
    }
  }
}