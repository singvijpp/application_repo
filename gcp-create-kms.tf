
/* provider "google" {

project = "db-cicdpipeline-wave3"

region = "asia-south2-a"
} */

resource "google_kms_key_ring" "kms_key_ring_gcp" {

  name = "kms_key_ring_gcp"

  location = "asia-east1"

}

resource "google_kms_crypto_key" "kms_crypto_key_gcp" {

  name = "kms_crypto_key_gcp"

  key_ring = "google_kms_key_ring.kms_key_ring_gcp.id"


  version_template {

    algorithm = "GOOGLE_SYMMETRIC_ENCRYPTION"

  }
}


