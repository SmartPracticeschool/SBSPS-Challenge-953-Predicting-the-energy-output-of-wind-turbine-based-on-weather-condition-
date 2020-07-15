import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:async/async.dart';
import 'energy.dart';


class AccountScreen extends StatefulWidget {
  static const String routeName = "/account";
  @override
  AccountScreenState createState() => AccountScreenState();
}

class AccountScreenState extends State<AccountScreen>{

  List<Energy> energies =[];
  final String baseurl = "https://wind-energy-mk.herokuapp.com";

  void _fetchDataFromServer() async {
    final Dio dio = new Dio();

    try{
      var response = await dio.post("$baseurl/classifier/run -F hours=2");
      print(response.statusCode);
      print(response.data);
      var responseData = response.data as List;

      setState(() {
        energies = responseData.map((e) => Energy.fromJson(e)).toList();
      });
  }on DioError catch(e){
      print(e);
    }
    }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title :Row(
                children : <Widget>[
                  SizedBox(width: 20.0),
                  Text(
                    "One Hour",
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 23,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),

                  ),
                  SizedBox(width: 5.0),
                  Text(
                      "Forecast",
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
          body: Stack(
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

                ListView(
                  children:<Widget>[
                    ...energies.map(
                        (Energy) => ListTile(
                       title:Column(
                         children:<Widget>[
                           Text('${Energy.i_1}'),
                           SizedBox(height:7)
                         ]
                       ),
                        subtitle:
                          Text('${Energy.i_2}'),
                        )

                        )


                  ]
                ),
           FloatingActionButton(
            onPressed: _fetchDataFromServer,
             tooltip:'Fetch Data',
             child:Icon(Icons.cloud_download),
          )
              ],
      ),
      );
  }}

