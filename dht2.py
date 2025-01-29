import http.client
import urllib.parse
import time
key =  "579XWB75E1ERLBLX"
import board
import adafruit_dht
import psutil

for proc in psutil.process_iter():
    if proc.name() in ['libgpiod_pulsein', 'libgpiod_pulsei']:
        proc.kill()

sensor = adafruit_dht.DHT11(board.D21)

def thermometer():
    while True:
        
        temp = sensor.temperature
        humidity = sensor.humidity
            
        params = urllib.parse.urlencode({'field1': str(temp),'field2': str(humidity),'key': key})
        print("Sending data:", params)  # Debug output

        headers = {"Content-Type": "application/x-www-form-urlencoded","Accept": "text/plain"}
        conn = http.client.HTTPConnection("api.thingspeak.com, 80")
            
        try:
            conn.request("POST", "/update", params, headers)
            response = conn.getresponse()
                
            print("Temperature: {} °C, Humidity: {} %".format(temp, humidity))
            print(response.status, response.reason)
            data = response.read()
            conn.close()
        except:
            print("Connection failed")
            break
        
if __name__ == "__main__":
    while True:
        thermometer()


