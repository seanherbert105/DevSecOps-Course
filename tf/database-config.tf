resource "kubernetes_config_map_v1_data" "db-config" {
  metadata {
    name = "db-config"
  }
  data = {
    POSTGRES_DB="postgres"
    POSTGRES_USER="postgres"
    POSTGRES_PASSWORD="postgres"
  }
}