# hello_world_dag.py

from airflow import DAG
from airflow.operators.bash_operator import BashOperator
from datetime import datetime

default_args = {
    'owner': 'me',
    'start_date': datetime(2023, 8, 10),
    'retries': 1,
}

dag = DAG(
    'hello_world_dag',
    default_args=default_args,
    description='A simple hello world DAG',
    schedule_interval='*/10 * * * *',
    catchup=False,
)

bash_task = BashOperator(
    task_id='say_hello',
    bash_command='echo "Hello, World!"',
    dag=dag,
)
