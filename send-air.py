#add comments to each line 
import requests
url = 'https://docs.google.com/forms/d/e/1FAIpQLSdxNxAUBmiNpdlmuqm4JdimIrpyvfkfnXN_sAAc15M6suwitw/formResponse'
form_data = {'entry.958126804': '12.3',
              'draftResponse':[],
              'pageHistory':0}
user_agent = {'Referer':'https://docs.google.com/forms/d/e/1FAIpQLSdxNxAUBmiNpdlmuqm4JdimIrpyvfkfnXN_sAAc15M6suwitw/viewform','User-Agent': "Mozilla/5.0 (X11; Linux i686) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/28.0.1500.52 Safari/537.36"}
import serial
ser = serial.Serial('COM3', 9600, timeout=0)
while True:
     air_quality_read = float(ser.readline())
     form_data['entry.958126804'] = str(air_quality_read)
     print ("add datapoint", air_quality_read, "to google forms")
     r = requests.post(url, data=form_data, headers=user_agent)
     
import time
TOKEN = "A1E-sH1RVzj4UAUgfhPvIxMC1XevFWMk78"  # Put your TOKEN here
DEVICE_LABEL = "machine"  # Put your device label here 
VARIABLE_LABEL_1 = "air_quality_read"  # Put your first variable label here
def build_payload(variable_1):
     # Creates two random values for sending data
     value_1 = air_quality_read
 
     payload = {variable_1: value_1}
 
     return payload
 
 def post_request(payload):
     # Creates the headers for the HTTP requests
     url = "http://things.ubidots.com"
     url = "{}/api/v1.6/devices/{}".format(url, DEVICE_LABEL)
     headers = {"X-Auth-Token": TOKEN, "Content-Type": "application/json"}
 
     # Makes the HTTP requests
     status = 400
     attempts = 0
     while status >= 400 and attempts <= 5:
         req = requests.post(url=url, headers=headers, json=payload)
         status = req.status_code
         attempts += 1
         time.sleep(1)
 
     # Processes results
     if status >= 400:
         print("[ERROR] Could not send data after 5 attempts, please check \
             your token credentials and internet connection")
         return False
 
     print("[INFO] request made properly, your device is updated")
     return True
 
 
def main():
     payload = build_payload(VARIABLE_LABEL_1)
 
     print("[INFO] Attemping to send data")
     post_request(payload)
     print("[INFO] finished")
 
 
if __name__ == '__main__':
     while (True):
         main()
         time.sleep(1)
