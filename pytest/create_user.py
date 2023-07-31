import requests
import json

url = "https://reqres.in/api/users"

file = open("E:\old lappy files\yooyoooyoyooyoyyo\TCS-internal-project\pytest\createUser.json",'r')

json_input = file.read()
request_json = json.loads(json_input)
print(request_json)

response = requests.post(url,request_json)
print(response.content)

assert response.status_code == 201

#fetch hearder from response
print(response.headers)