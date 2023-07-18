resource "google_storage_bucket" "static" {
  name          = "gcp_wave3_cicd"
  location      = "US-CENTRAL1"
  force_destroy = true
}
