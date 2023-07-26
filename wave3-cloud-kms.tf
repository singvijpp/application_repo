resource "google_kms_key_ring" "wave3_kms_key_ring" {
  name     = "wave3-key-ring"
  location = "asia-south2"
}

resource "google_storage_bucket" "storage_bucket" {
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

# Create a KMS crypto key
resource "google_kms_crypto_key" "example_crypto_key" {
  name      = "example_crypto_key"
  key_ring  = google_kms_key_ring.wave3_kms_key_ring.id
}