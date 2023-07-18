resource "google_storage_bucket" "auto-expire" {
  name          = "gcp_wave3_cicd"
  location      = "APAC"
  force_destroy = true
}
