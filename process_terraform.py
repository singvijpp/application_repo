import openai
import os
import glob
import requests

openai.api_key = os.environ['OPENAI_API_KEY']  # Assuming it's set as an environment variable
url = "https://openai.com/v1/"
print("Requesting URL:", url)
response = requests.get(url, headers={...})

def process_file(file_path):
    with open(file_path, 'r') as f:
        content = f.read()
        response = openai.ChatCompletion.create(
            engine="gpt-4-0314",
            messages=[
                {"role": "system", "content": "You are a helpful assistant."},
                {"role": "user", "content": "who is best cricket batsman in world cricket"}
            ],
            max_tokens = 150,
            n = 1,
            temperature = 0.5,
        )
        print(f"Documentation for {file_path}:")
        print(response.choices[0].text.strip())

# Process all Terraform files in the repository
for file in glob.glob("**/*.tf", recursive=True):
    process_file(file)
