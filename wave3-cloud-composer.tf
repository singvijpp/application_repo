#   Usage:
#   The script provisions the following resources in the project:
#	- Creates a Cloud Composer environment
#	- Creates a Composer Service Agent account
#	- Grants the Cloud Composer v2 API Service Agent Extension role and the Composer Worker role to the Composer Service Agent account
#	- Creates a new Cloud Storage bucket
#	- Creates a new Cloud Function and deploys the function source code from the pubsub_function.zip file to the Cloud Storage bucket
#	- Uploads the example DAG source code from the specified file into the Cloud Composer bucket

#

resource "google_project_service" "composer" {
  project = "db-cicdpipeline-wave3"
  service = "composer.googleapis.com"

  timeouts {
    create = "30m"
    update = "40m"
  }

  disable_dependent_services = true
  disable_on_destroy         = false
}

###############################
#                             #
# Create Composer environment #
#                             #
###############################
resource "google_composer_environment" "new_composer_env" {
  name    = "composer-environment"
  region  = "asia-south2"
  project = "db-cicdpipeline-wave3"
  config {

    software_config {
      image_version = "composer-2-airflow-2"
    }
    workloads_config {
      scheduler {
        cpu        = 0.5
        memory_gb  = 1.875
        storage_gb = 1
        count      = 1
      }
      web_server {
        cpu        = 0.5
        memory_gb  = 1.875
        storage_gb = 1
      }
      worker {
        cpu        = 0.5
        memory_gb  = 1.875
        storage_gb = 1
        min_count  = 1
        max_count  = 3
      }


    }
    environment_size = "ENVIRONMENT_SIZE_SMALL"

	  node_config {
		network         = "projects/db-cicdpipeline-wave3/regions/asia-south2/network/wave-3"
		subnetwork      = "projects/db-cicdpipeline-wave3/regions/asia-south2/subnetworks/asia-south-1"
		service_account = "cicd-wave3-composer-sa@db-cicdpipeline-wave3.iam.gserviceaccount.com"
    }
	encryption_config {
			kms_key_name = "projects/db-cicdpipeline-wave3/locations/asia-south2/keyRings/kms_key_ring_new/cryptoKeys/crypto-key-new"
			
    }
	recovery_config	{
		scheduled_snapshots_config {
			enabled = true 
			snapshot_location = "gs://db-cicd-wave3/environment_snapshots2"
			snapshot_creation_schedule = "0 0 * * *"
			time_zone =                  "UTC+01"

		}
	}

  }
}


#########################
#                       #
# Creates IAM resources #
#                       #
#########################
# Comment this section to use an existing service account
resource "google_service_account" "composer_env_sa" {
  project      = "db-cicdpipeline-wave3"
  account_id   = "cicd-wave3-composer-sa"
  display_name = "Test Service Account for Composer Environment deployment "
}

resource "google_project_service_identity" "composer_sa" {
  provider = google-beta
  project  = "db-cicdpipeline-wave3"
  service  = "composer.googleapis.com"
}  

resource "google_kms_crypto_key_iam_binding" "composer_encrypter_decrypter" {
  crypto_key_id = "projects/db-cicdpipeline-wave3/locations/asia-south2/keyRings/kms_key_ring_new/cryptoKeys/crypto-key-new"

  role = "roles/cloudkms.cryptoKeyEncrypterDecrypter"

  members = [
    "serviceAccount:service-36949417800@cloudcomposer-accounts.iam.gserviceaccount.com",
	"serviceAccount:${google_service_account.composer_env_sa.email}",
  ]
}

variable "service_accounts" {
  description = "List of service accounts"
  type        = list(string)
  default     = [ "service-36949417800@cloudcomposer-accounts.iam.gserviceaccount.com",
                 "service-36949417800@container-engine-robot.iam.gserviceaccount.com",
				 "service-36949417800@compute-system.iam.gserviceaccount.com",
				 "cicd-wave3-serviceaccot@db-cicdpipeline-wave3.iam.gserviceaccount.com",
				 "36949417800@cloudservices.gserviceaccount.com",
				 "36949417800-compute@developer.gserviceaccount.com",
				 "cicd-wave3-composer-sa@db-cicdpipeline-wave3.iam.gserviceaccount.com",
				 "service-36949417800@gcp-sa-pubsub.iam.gserviceaccount.com",
				 "service-36949417800@gcp-sa-artifactregistry.iam.gserviceaccount.com"]
  
}

resource "google_project_iam_member" "kms_roles" {
  for_each = toset(var.service_accounts)
  project = "db-cicdpipeline-wave3"
  role    = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member  = "serviceAccount:${each.value}"
}


resource "google_project_iam_member" "composer_ext_roles" {
  for_each = toset(var.service_accounts)
  project = "db-cicdpipeline-wave3"
  role    = "roles/composer.ServiceAgentV2Ext"
  member  = "serviceAccount:${each.value}"
}

resource "google_project_iam_member" "composer_worker_roles" {
  for_each = toset(var.service_accounts)
  project = "db-cicdpipeline-wave3"
  role    = "roles/composer.worker"
  member  = "serviceAccount:${each.value}"
}

resource "google_project_iam_member" "composer_user_roles" {
  for_each = toset(var.service_accounts)
  project = "db-cicdpipeline-wave3"
  role    = "roles/composer.user"
  member  = "serviceAccount:${each.value}"
}

resource "google_project_iam_member" "composer_sql_roles" {
  for_each = toset(var.service_accounts)
  project = "db-cicdpipeline-wave3"
  role    = "roles/cloudsql.admin"
  member  = "serviceAccount:${each.value}"
}


resource "google_project_iam_member" "act_as" {
  project  = "db-cicdpipeline-wave3"
  role    = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member  = "serviceAccount:${google_service_account.composer_env_sa.email}"
}

resource "google_service_account_iam_member" "custom_service_account" {
  provider           = google-beta
  service_account_id = google_service_account.composer_env_sa.id
  role               = "roles/composer.ServiceAgentV2Ext"
  member             = "serviceAccount:${google_service_account.composer_env_sa.email}"
}

resource "google_project_iam_member" "composer_worker" {
  project = "db-cicdpipeline-wave3"
  role    = "roles/composer.worker"
  member  = "serviceAccount:${google_service_account.composer_env_sa.email}"
}

resource "google_project_iam_member" "composer_sql" {
  project = "db-cicdpipeline-wave3"
  role    = "roles/cloudsql.admin"
  member  = "serviceAccount:${google_service_account.composer_env_sa.email}"
}