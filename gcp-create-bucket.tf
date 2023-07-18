resource "google_storage_bucket" "auto-expire" {
  name          = "gcp_wave3_cicd"
  region      = "ASIA-SOUTH1"
  force_destroy = true
}
