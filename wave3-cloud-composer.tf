resource "google_composer_environment" "test" {
  name   = "example-composer-env"
  region = "asia_south2"
  config {
    node_count = 4

    node_config {
      zone         = "asia_south2-a"
      machine_type = "n1-standard-1"

      service_account = google_service_account.test.name
    }

    database_config {
      machine_type = "db-n1-standard-2"
    }

    web_server_config {
      machine_type = "composer-n1-webserver-2"
    }
  }
}
resource "google_service_account" "test" {
  account_id   = "composer-env-account"
  display_name = "Test Service Account for Composer Environment"
}