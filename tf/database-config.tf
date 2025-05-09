resource "kubernetes_config_map" "db-config" {
  metadata {
    name = "db-config"
  }

  data = {
    POSTGRES_DB="postgres"
    POSTGRES_USER="postgres"
    POSTGRES_PASSWORD="postgres"
  }
}