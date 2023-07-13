resource "google_storage_bucket" "bucket" {
  name          = "terraform_bucket_cicd"
  location      = "asia-south2"
  force_destroy = true

  versioning {
    enabled = true
  }

  lifecycle_rule {
    condition {
      age = 30
    }
    action {
      type = "Delete"
    }
  }
}
