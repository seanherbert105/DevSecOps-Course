resource "kubernetes_service_v1" "result-service" {
  metadata {
    name = "result"
  }

  spec {
    selector = {
      app = "result"
    }

    port {
      port        = 8001
      target_port = 80
      node_port   = 31000
    }

    type = "NodePort"
  }
}