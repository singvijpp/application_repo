resource "google_kms_key_ring" "wave3_kms_key_ring" {
  name     = "wave3-key-ring"
  location = "global"
}

resource "google_kms_crypto_key" "wave3_kms_crypto_key" {
  name            = "wave3-crypto-key"
  key_ring        = google_kms_key_ring.wave3_kms_key_ring.self_link
  rotation_period = "100000s"
}

resource "google_storage_bucket_iam_member" "wave3_kms_bucket_iam_member" {
  bucket = google_storage_bucket.wave3_cicd_bucket.name
  role   = "roles/storage.objectViewer"
  member = "serviceAccount:${google_kms_crypto_key.wave3_kms_crypto_key.primary_key_ring}"
}