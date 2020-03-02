import requests

url = "http://192.168.100.1/#/"
creds = {''}



#headers to use once we are authenticated
headers = {
    'Origin': 'http://192.168.100.1',
    'Accept-Encoding': 'gzip, deflate',
    'Accept-Language': 'en-US,en;q=0.9',
    'User-Agent': 'Mozilla/5.0.89 Safari/537.36',
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Referer': 'http://192.168.100.1/?',
    'Connection': 'keep-alive',
}
# data to post once logged in
data = '{"jsonrpc":"2.0","id":0,"method":"call","params":["6e6706efefc252005ad21e26437764d1","file","exec",{"command":"ping","params":["google.com"]}]}'
# post request to be made
response = requests.post('http://192.168.100.1/ubus', headers=headers, data=data)
