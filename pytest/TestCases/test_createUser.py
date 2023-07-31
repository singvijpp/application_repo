import requests
import json

url = "https://reqres.in/api/users"

def test_create_new_user() :
    file = open("E:\old lappy files\yooyoooyoyooyoyyo\TCS-internal-project\pytest\createUser.json",'r')

    json_input = file.read()
    request_json = json.loads(json_input)
    print(request_json)
    #MAKE post request with json input
    response = requests.post(url,request_json)
    print(response.content)
    #assert response.status_code == 201
    assert response.status_code == 202
    #fetch hearder from response
    print(response.headers)

def test_create_other_user() :
    file = open("E:\old lappy files\yooyoooyoyooyoyyo\TCS-internal-project\pytest\createUser.json",'r')

    json_input = file.read()
    request_json = json.loads(json_input)
    print(request_json)
    #MAKE post request with json input
    response = requests.post(url,request_json)
    print(response.content)
    #validating response code
    #assert response.status_code == 201
    #assert response.status_code == 202
    #fetch hearder from response
    print(response.headers)