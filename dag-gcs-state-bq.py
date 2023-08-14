import datetime
import json

from airflow import DAG
from airflow.operators.python_operator import PythonOperator
from google.cloud import storage
from google.cloud import bigquery

default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'start_date': datetime.datetime(2023, 8, 14),  # Change to your desired start date
    'retries': 1,
    'retry_delay': datetime.timedelta(minutes=5),
}

def fetch_tf_state_from_gcs(**kwargs):
    bucket_name = "terraform_bucket_cicd_2"
    blob_name = 'terraform/state/default.tfstate'
    
    client = storage.Client()
    bucket = client.get_bucket(bucket_name)
    blob = bucket.blob(blob_name)
    
    tf_state_content = blob.download_as_text()
    
    # Passing the state content to the next task
    kwargs['ti'].xcom_push(key='tf_state_content', value=tf_state_content)

def insert_into_bigquery(**kwargs):
    ti = kwargs['ti']
    tf_state_content = ti.xcom_pull(task_ids='fetch_tf_state_task', key='tf_state_content')
    tf_state_data = json.loads(tf_state_content)

    # Extract the necessary data from the state file and transform it to tabular format.
    # For demonstration purposes, let's assume you just want resources.
    resources = tf_state_data.get('resources', [])

    # Create rows for BigQuery
    rows_to_insert = [
        {'type': resource['type'], 'name': resource['name']}
        for resource in resources
    ]

    # Insert into BigQuery
    client = bigquery.Client()
    table_id = 'db-cicd-wave3.terraform_state_dataset.terraform_state_table'
    errors = client.insert_rows_json(table_id, rows_to_insert)
    if errors:
        raise RuntimeError(f"BigQuery insert failed: {errors}")

with DAG('terraform_state_to_bigquery',
         default_args=default_args,
         description='Fetch terraform state from GCS and insert into BigQuery',
         schedule_interval=None,  # Or set to your desired interval
         ) as dag:

    fetch_tf_state_task = PythonOperator(
        task_id='fetch_tf_state_from_gcs',
        python_callable=fetch_tf_state_from_gcs,
        provide_context=True
    )

    insert_into_bigquery_task = PythonOperator(
        task_id='insert_into_bigquery',
        python_callable=insert_into_bigquery,
        provide_context=True
    )

    fetch_tf_state_task >> insert_into_bigquery_task
