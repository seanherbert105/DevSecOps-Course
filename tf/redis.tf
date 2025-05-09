resource "kubernetes_stateful_set_v1" "redis" {
  metadata {
    name = "redis"

    annotations = {
      SomeAnnotation = "foobar"
    }

    labels = {
      k8s-app                            = "redis"
      "kubernetes.io/cluster-service"    = "true"
      "addonmanager.kubernetes.io/mode"  = "Reconcile"
      version                            = "v1.0.0"
    }
  }

  spec {
    service_name="redis-service"
    replicas=1

    selector {
      match_labels = {
        k8s-app="redis"
      }
    }

    template {
      metadata {
        labels = {
          k8s-app="redis"
        }

        annotations = {}
      }

      spec {
        container {
          name="redis"
          image="redis:alpine"
          image_pull_policy="IfNotPresent"

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
            container_port=6379
          }
        }
      }
    }
  }
}