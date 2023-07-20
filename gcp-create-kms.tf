
provider "google" {

project = "db-cicdpipeline-wave3"

region = "asia-south2-a"
}

resource "google_kms_key_ring" "gcp_wave3_ring" {

  name = "gcp_wave3_ring"

  location = "asia-east2"

}

resource "google_kms_crypto_key" "gcp_crypto_key_kms" {

  name = "gcp_crypto_key_kms"

  key_ring = "google_kms_key_ring.gcp_wave3_ring"


  version_template {

    algorithm = "GOOGLE_SYMMETRIC_ENCRYPTION"

  }
}


