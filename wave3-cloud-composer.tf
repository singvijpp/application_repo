#   Usage:
#       1. Select or create a new project that you will use to create the resources
#       2. Set up your environment and apply the configuration using basic Terraform commands: https://cloud.google.com/docs/terraform/basic-commands
#
#   The script provisions the following resources in the project:
#  	- Creates a VPC network and a subnetwork
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
		network         = "wave-3"
		subnetwork      = "asia-south-1"
		service_account = google_service_account.composer_env_sa.email
    }
	dynamic "encryption_config" {
      for_each = var.kms_key_name != null ? [
        {
          kms_key_name = var.kms_key_name
      }] : []
      content {
        kms_key_name = encryption_config.value["kms_key_name"]
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

resource "google_project_iam_member" "composer_worker" {
  project = "db-cicdpipeline-wave3"
  role    = "roles/composer.worker"
  member  = "serviceAccount:${google_service_account.composer_env_sa.email}"
}

resource "google_service_account_iam_member" "custom_service_account" {
  provider           = google-beta
  service_account_id = google_service_account.composer_env_sa.id
  role               = "roles/composer.ServiceAgentV2Ext"
  member             = "serviceAccount:${google_project_service_identity.composer_sa.email}"
}


#########################
#                       #
# Enable Cloud F api 	#
#                       #
#########################

resource "google_project_service" "cloud_function" {
  project = data.google_project.project.project_id
  service = "cloudfunctions.googleapis.com"

  timeouts {
    create = "30m"
    update = "40m"
  }

  disable_dependent_services = true
  disable_on_destroy         = false
}

########################
#                      #
# Creates PubSub topic #
#                      #
########################
resource "google_pubsub_topic" "trigger" {
  project                    = data.google_project.project.project_id
  name                       = "dag-topic-trigger"
  message_retention_duration = "86600s"
}

##########################
#                        #
# Creates Cloud Function #
#                        #
##########################
resource "google_cloudfunctions_function" "pubsub_function" {
  project = data.google_project.project.project_id
  name    = "pubsub-publisher"
  runtime = "python310"
  region  = "us-central1"

  available_memory_mb   = 128
  source_archive_bucket = google_storage_bucket.cloud_function_bucket.name
  source_archive_object = google_storage_bucket_object.cloud_function_source.output_name
  timeout               = 60
  entry_point           = "pubsub_publisher"
  service_account_email = "${data.google_project.project.number}-compute@developer.gserviceaccount.com"
  trigger_http          = true

}


###################
#                 #
# Upload Dag file #
#                 #
###################

resource "google_storage_bucket_object" "composer_dags_source" {
  name   = "dags/dag-pubsub-sensor-py-file"
  bucket = trimprefix(trimsuffix(google_composer_environment.new_composer_env.config[0].dag_gcs_prefix, "/dags"), "gs://")
  source = "./pubsub_trigger_response_dag.py"
}
# [END triggering_dags_with_functions_and_pubsub]