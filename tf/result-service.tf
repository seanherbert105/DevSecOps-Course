resource "kubernetes_service" "result-service" {
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
      node_port   = 3100
    }

    type = "NodePort"
  }
}