resource "google_kms_key_ring" "kms_key_ring" {
  name     = "key-ring"
  location = "asia-south2"
}

resource "google_kms_crypto_key" "kms_crypto_key" {
  name            = "crypto-key"
  key_ring        = google_kms_key_ring.kms_key_ring.id
  rotation_period = "2592000s"

}

resource "google_kms_crypto_key_iam_binding" "crypto_key" {
  crypto_key_id = google_kms_crypto_key.kms_crypto_key.id
  role          = "roles/cloudkms.cryptoKeyEncrypter"

  members = [
    "serviceAccount:cicd-wave3-serviceaccot@db-cicdpipeline-wave3.iam.gserviceaccount.com",
  ]
}
