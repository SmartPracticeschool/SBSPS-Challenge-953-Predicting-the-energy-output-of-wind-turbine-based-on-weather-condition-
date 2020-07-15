from flask import Flask,abort
from importlib import import_module
import os
import jsonpickle
import json
from flask import Flask,Response , request , flash , url_for,jsonify
import logging
from logging.config import dictConfig
import numpy as np
import tensorflow as tf
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense
from tensorflow.keras.models import model_from_json
from tensorflow.keras.models import load_model
from tensorflow.keras.layers import LSTM
#from keras.models import model_from_json
from sklearn.preprocessing import MinMaxScaler
from sklearn.metrics import mean_squared_error
import requests

app = Flask(__name__)
	
@app.route('/classifier/run',methods=['POST'])
def classify():
    app.logger.debug('Running classifier')
    hours= request.form['hours']
    hours=int(hours)
    #load_image() is to process image : 
    w_degree,w_speed,scaler_deg,scaler_speed= load_dataset()
    #print(w_degree,w_speed,hours)
    #print('image ready')
    try:
        power = run_model(w_degree,w_speed,scaler_deg,scaler_speed,hours)
        energy={}
        for i in range(48):
            energy[i]=power[i]
        return json.dumps(energy)
    #except FileNotFoundError as e:
        #return abort('Unable to locate image: %s.' % str(e), 503)
    except Exception as e:
        return abort('Unable to process : %s.' % str(e), 500)	


def load_dataset():
    response = requests.get("https://api.openweathermap.org/data/2.5/onecall?lat=8.2600&lon=77.5475&exclude=current,minutely,daily&appid=40ca97781375cb5dc8be51dbf2691514")
    dic = json.loads(response.content)
    x=dic['hourly']
    wind_deg=[]
    wind_speed=[]
    for i in range(len(x)):
        wind_deg.append(x[i]['wind_deg'])
        wind_speed.append(x[i]['wind_speed'])
    wind_deg=np.array(wind_deg)
    wind_deg=wind_deg.reshape(-1,1)
    wind_speed=np.array(wind_speed)
    wind_speed=wind_speed.reshape(-1,1)
    scaler_deg = MinMaxScaler(feature_range=(0, 1))
    wind_deg= scaler_deg.fit_transform(wind_deg)

    scaler_speed = MinMaxScaler(feature_range=(0, 1))
    wind_speed= scaler_speed.fit_transform(wind_speed)
    
    wind_deg=wind_deg.reshape(-1,1,1)
    wind_speed=wind_speed.reshape(-1,1,1)
    return wind_deg,wind_speed,scaler_deg,scaler_speed


def run_model(w_degree,w_speed,scaler_deg,scaler_speed,hours):    
    app.logger.error('Loading model')    
    try:
        #loading wind degree model
        model_deg=Sequential()
        model_deg.add(LSTM(4,input_shape=(1,1)))
        model_deg.add(Dense(1))
        model_deg.compile(loss='mean_squared_error', optimizer='adam')
        model_deg.load_weights('IBM_hack_wind_deg.h5')

        model_speed=Sequential()
        model_speed.add(LSTM(4,input_shape=(1,1)))
        model_speed.add(Dense(1))
        model_speed.compile(loss='mean_squared_error', optimizer='adam')
        model_speed.load_weights('IBM_hack_wind_speed.h5')
    except FileNotFoundError as e :
        return abort('Unable to find the file: %s.' % str(e), 503)
		
    for i in range(len(w_degree)+hours*48):
        x=model_deg.predict(w_degree[i:i+1,:,:])
        x=x[:,:,np.newaxis]
        w_degree=np.concatenate((w_degree,x))
        
    for i in range(len(w_speed)+hours*48):
        x=model_deg.predict(w_speed[i:i+1,:,:])
        x=x[:,:,np.newaxis]
        w_speed=np.concatenate((w_speed,x))

    
	
    power=[]
    for i in range(len(w_speed[:,0,0])-48,len(w_speed[:,0,0])):
        x=scaler_speed.inverse_transform(w_speed[i:i+1,:,0])
        power.append(0.5*1.23*3.14*(45**2)*(x[0,0]**3)/1000)
    return power

@app.route('/')
def index():
    return "<h1>Welcome to our server !!</h1>"

if __name__=='__main__':
    app.run(host='0.0.0.0',port=5000,debug=True,threaded=True)



