provider "google" {
  project     = "db-cicdpipeline-wave3"
  region      = "asia-south2"
  zone        ="asia-south2-a"
}

resource "google_storage_bucket" "test-bucket-for-state" {
 name          = "db-cicd-wave3"
 location      = "US"
 storage_class = "STANDARD"
 force_destroy = true

 uniform_bucket_level_access = true
 
   lifecycle_rule {
    condition {
      age = 30
    }
  
action {
      type = "Delete"
    }
  }
  
}

resource "google_kms_key_ring" "keyring" {

  name = var.keyring_name

  location = var.region

}

resource "google_kms_crypto_key" "key" {

  name = var.key_name

  key_ring = google_kms_key_ring.keyring.id

  rotation_period = var.rotation_period


  version_template {

    algorithm = var.algorithm

  }


  lifecycle {

    prevent_destroy = false

  }

}

resource "google_kms_crypto_key_iam_binding" "crypto_key" {

  crypto_key_id = google_kms_crypto_key.key.id

  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"

  members       = [
     "serviceAccount:cicd-wave3-serviceaccot@db-cicdpipeline-wave3.iam.gserviceaccount.com",

  ]

}

terraform {
	backend "gcs" {
		bucket = "db-cicd-wave3"
		prefix = "terraform/state"
	}
}
