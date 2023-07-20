provider "google" {
  project = "db-cicdpipeline-wave3"
  zone = "asia-south1-a"
}
resource "google_kms_key_ring" "kms_key_ring_wave3" {
  name = "kms_key_ring_wave3"
  location = "asia-south1"
}
resource "google_kms_crypto_key" "kms_crypto_key_wave3" {
  name = "kms_crypto_key_wave3"
  key_ring = google_kms_key_ring.kms_key_ring_wave3.self_link
}
