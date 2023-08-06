import openai
import os
import glob

openai.api_key = os.environ['OPENAI_API_KEY']  # Assuming it's set as an environment variable
def process_file(file_path):
    with open(file_path, 'r') as f:
        content = f.read()
        response = openai.Completion.create(
            engine="gpt-3.5-turbo", 
            messages=[ {"role": "system", "content": {content}},
                       {"role": "user", "content": "Translate the following English text to French: 'Hello, how are you?'"},
                     ]
            max_tokens=500
        )
        print(f"Documentation for {file_path}:")
        print(response.choices[0].text.strip())

# Process all Terraform files in the repository
for file in glob.glob("**/*.tf", recursive=True):
    process_file(file)
