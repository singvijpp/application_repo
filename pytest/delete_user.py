import requests

url = "https://reqres.in/api/users/2"

response = requests.delete(url)
print(response)


assert response.status_code == 202