
resource "google_kms_key_ring" "default" {

  name = "gcp-wave3-ring"

  location = "asia-east2"

}

resource "google_kms_crypto_key" "key" {

  name = "gcp-wave3-key"

  key_ring = "google_kms_key_ring.keyring.id"


  version_template {

    algorithm = "GOOGLE_SYMMETRIC_ENCRYPTION"

  }


}
