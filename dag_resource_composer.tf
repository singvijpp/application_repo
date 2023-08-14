data "google_composer_environment" "existing_env" {
  project = "db-cicdpipeline-wave3"
  name    = google_composer_environment.new_composer_env.name
  region  = "asia-south2"
}


resource "google_storage_bucket_object" "dag_object" {
  name   = "dags/hello_world_dag.py"
  bucket = trimprefix(trimsuffix(google_composer_environment.new_composer_env.config[0].dag_gcs_prefix, "/dags"), "gs://")
  source = "hello_world_dag.py" 
  # Ensure you replace the above with your local path
}

resource "google_storage_bucket_object" "gcs_bq_dag_object" {
  name   = "dags/dag-gcs-state-bq.py"
  bucket = trimprefix(trimsuffix(google_composer_environment.new_composer_env.config[0].dag_gcs_prefix, "/dags"), "gs://")
  source = "dag-gcs-state-bq.py" 
  # Ensure you replace the above with your local path
}
