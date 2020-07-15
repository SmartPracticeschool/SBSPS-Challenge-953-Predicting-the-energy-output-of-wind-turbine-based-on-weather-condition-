import 'package:flutter/material.dart';
import 'models/ForecastData.dart';
import 'models/WeatherData.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'widgets/Weather.dart';
import 'widgets/WeatherItem.dart';


class PowerScreen extends StatefulWidget {
  static const String routeName = "/power";
  @override
  PowerScreenState createState() => PowerScreenState();
}

class PowerScreenState extends State<PowerScreen>{

  bool isLoading = false;
  WeatherData weatherData;
  ForecastData forecastData;

  @override
  void initState() {
    super.initState();

    loadWeather();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          title :Row(
              children : <Widget>[
                SizedBox(width: 20.0),
                Text(
                  "Weather",
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 23,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),

                ),
                SizedBox(width: 5.0),
                Text(
                    "Now",
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 23,
                      color: Colors.white,
                    )
                )]
          ) ,
          backgroundColor: Colors.lightBlueAccent[700],
          elevation: 0.0,
        ),
          body:Stack(
            children:[
              Center (child:Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[
                          Colors.lightBlueAccent[700],
                          Colors.lightBlueAccent[100],
                        ])
                ),
              ),
              ),
          Center(
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: weatherData != null ? Weather(weather: weatherData) : Container(),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: isLoading ? CircularProgressIndicator(
                              strokeWidth: 2.0,
                              valueColor: new AlwaysStoppedAnimation(Colors.white),
                            ) : IconButton(
                              icon: new Icon(Icons.refresh),
                              tooltip: 'Refresh',
                              onPressed: loadWeather,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 200.0,
                          child: forecastData != null ? ListView.builder(
                              itemCount: forecastData.list.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => WeatherItem(weather: forecastData.list.elementAt(index))
                          ) : Container(),
                        ),
                      ),
                    )
                  ]
              )
          )
          ],),
    );
  }

  loadWeather() async {
    setState(() {
      isLoading = true;
    });

    final lat = 11.5450;
    final lon = 79.5212;
    final weatherResponse = await http.get(
        'https://api.openweathermap.org/data/2.5/weather?APPID=91ffd96ea9b199fc8b27691304cbc549&lat=${lat
            .toString()}&lon=${lon.toString()}');
    final forecastResponse = await http.get(
        'https://api.openweathermap.org/data/2.5/forecast?APPID=91ffd96ea9b199fc8b27691304cbc549&lat=${lat
            .toString()}&lon=${lon.toString()}');

    if (weatherResponse.statusCode == 200 &&
        forecastResponse.statusCode == 200) {
      return setState(() {
        weatherData = new WeatherData.fromJson(jsonDecode(weatherResponse.body));
        forecastData = new ForecastData.fromJson(jsonDecode(forecastResponse.body));
        isLoading = false;
      });
    }

    setState(() {
      isLoading = false;
    });
  }
}


