import datetime
from airflow import DAG
from airflow.providers.google.cloud.transfers.gcs_to_bigquery import GCSToBigQueryOperator

default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'start_date': datetime.datetime(2023, 8, 14),
    'retries': 1,
    'retry_delay': datetime.timedelta(minutes=5),
}

with DAG('terraform_state_to_bigquery',
         default_args=default_args,
         description='Fetch terraform state from GCS and insert into BigQuery',
         schedule_interval=None,
         ) as dag:

    load_tf_state_to_bigquery = GCSToBigQueryOperator(
        task_id='load_tf_state_to_bigquery',
        bucket='terraform_bucket_cicd_2',
        source_objects=['terraform/state/default.tfstate'],
        destination_project_dataset_table='db-cicd-wave3.terraform_state_dataset.terraform_state_table',
        skip_leading_rows=1, # assuming you have a header row in your state file, adjust if not
        source_format='NEWLINE_DELIMITED_JSON',
        write_disposition='WRITE_TRUNCATE', # this will replace existing data in the table
    )

    load_tf_state_to_bigquery