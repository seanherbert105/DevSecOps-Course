resource "kubernetes_service_v1" "vote-service" {
  metadata {
    name = "vote"
  }
  
  spec {
    selector = {
      app = "vote"
    }

    port {
      port        = 8080
      target_port = 80
      node_port   = 31000
    }

    type = "NodePort"
  }
}