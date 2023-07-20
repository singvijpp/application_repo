
resource "google_kms_key_ring" "default" {

  name = "gcp-wave3-ring"

  location = "asia-east2"

}


  version_template {

    algorithm = "GOOGLE_SYMMETRIC_ENCRYPTION"

  }



