
provider "google" {

project = "db-cicdpipeline-wave3"

region = "asia-south2"
}  

resource "google_project_service" "project_cloudkms" {
  project = "db-cicdpipeline-wave3"
  service = "cloudkms.googleapis.com"
}

resource "google_project_iam_member" "kmsapi" {
  project = "db-cicdpipeline-wave3"
  role    = "roles/editor"
  member  = "serviceAccount:cicd-wave3-serviceaccot@db-cicdpipeline-wave3.iam.gserviceaccount.com"
}

resource "google_kms_key_ring" "kms_key_ring_temp" {

  name = "kms_key_ring_temp"

  location = "asia-south2"

}

resource "google_kms_crypto_key" "kms_crypto_key_temp" {

  name = "kms_crypto_key_temp"

  key_ring = "${google_kms_key_ring.kms_key_ring_gcp.self_link}"


  version_template {

    algorithm = "GOOGLE_SYMMETRIC_ENCRYPTION"

  }
}



