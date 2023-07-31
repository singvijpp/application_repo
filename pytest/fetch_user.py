import requests
import json
import jsonpath

url = "https://reqres.in/api/users?page=2"

#send GET request 

response = requests.get(url)

#display response content
#print(response.content)

#fetch the response and convert it in format of json 
#i.e prase the response to json format
json_response = json.loads(response.text)
#print(json_response)

pages = jsonpath.jsonpath(json_response,'total_pages')
print(pages[0])

assert pages[0] == 2