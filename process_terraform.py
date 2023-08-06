import openai
import os
import glob

openai.api_key = "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"  # Assuming it's set as an environment variable

def process_file(file_path):
    with open(file_path, 'r') as f:
        content = f.read()
        response = openai.Completion.create(
            engine="gpt-4.0-turbo", 
            prompt=f"Generate documentation for this Terraform code: {content}",  
            max_tokens=500
        )
        print(f"Documentation for {file_path}:")
        print(response.choices[0].text.strip())

# Process all Terraform files in the repository
for file in glob.glob("**/*.tf", recursive=True):
    process_file(file)
