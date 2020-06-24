import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  static const String routeName = "/account";

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
        backgroundColor: Colors.lightBlue[300],
        elevation: 0.0,
      ),
      body:
            Center (child:Container(
             decoration : BoxDecoration(
              gradient: LinearGradient(
               begin:Alignment.topCenter ,
                end: Alignment.bottomCenter,
               colors: [Colors.lightBlue[300],Colors.lightBlue[200],Colors.lightBlue[100],Colors.lightBlue[50]])
              
             ),
           ),
           ),
    );
  }
}
