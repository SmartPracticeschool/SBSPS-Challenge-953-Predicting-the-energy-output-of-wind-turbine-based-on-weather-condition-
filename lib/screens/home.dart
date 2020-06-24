import 'package:flutter/material.dart';
import 'account.dart';
import 'settings.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}



class HomeScreenState extends State<HomeScreen> {
  Drawer getNavDrawer(BuildContext context) {
    var headerChild =DrawerHeader(
              child: Text(''),
              decoration: BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                  image: AssetImage("assets/download.png"),
                     fit: BoxFit.cover)
              ),
            );
    var aboutChild = AboutListTile(
        child:  Container(
          height : 50.0,
         decoration : BoxDecoration(
               color : Colors.lightBlue[300],
               borderRadius : BorderRadius.only(topRight:Radius.circular(20.0),topLeft:Radius.circular(20.0),bottomRight:Radius.circular(20.0),bottomLeft:Radius.circular(20.0)
         )),
       child : Row(
         children : <Widget>[
        Icon(Icons.info,color: Colors.black87,),
        SizedBox(width: 5.0),
       Text('About',style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 20,
                color: Colors.black,
              )
              )
         ]
         )
              ),
        applicationName: "Wind Power Forecasting",
        applicationVersion: "v1.0.0",
        applicationIcon: Icon(Icons.adb),
        );
      
    ListTile getNavItem(var icon, Color col, String s, String routeName) {
      return ListTile( 
        title: Column(
          children : <Widget>[
        Container(
          height : 50.0,
         decoration : BoxDecoration(
               color : col,
               borderRadius : BorderRadius.only(topRight:Radius.circular(20.0),topLeft:Radius.circular(20.0),bottomRight:Radius.circular(20.0),bottomLeft:Radius.circular(20.0)
         )),
       child :
        Row(
         children : <Widget>[
        Icon(icon,color: Colors.black,),
        SizedBox(width: 5.0),
       Text(s,style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 20,
                color: Colors.black,
              )
              ),
            
         ]
         ),
        
          ),
          SizedBox(height: 20.0)
          
          ]
          
          ),
        onTap: () {
          setState(() {
            // pop closes the drawer
            Navigator.of(context).pop();
            // navigate to the route
            Navigator.of(context).pushNamed(routeName);
          });
        },
      );
    }

    var myNavChildren = [
      headerChild,
      SizedBox(height: 40.0),
      getNavItem(Icons.home,Colors.lightBlue[50], "Home", "/"),
      getNavItem(Icons.arrow_right,Colors.lightBlue[100], "Hourly Forecast", SettingsScreen.routeName),
      getNavItem(Icons.arrow_right,Colors.lightBlue[200],"One Hour Forecast", AccountScreen.routeName),
      aboutChild
    ];

    ListView listView = ListView(children: myNavChildren);

    return Drawer(
      child: 
          Stack( children:[
           Center (child:Container(
             decoration : BoxDecoration(
              gradient: LinearGradient(
               begin:Alignment.bottomCenter ,
                end: Alignment.topCenter,
               colors: [Colors.lightBlue[300],Colors.lightBlue[200],Colors.lightBlue[100],Colors.lightBlue[50],Colors.white])
              
             ),
           ),
           ),
              listView       
          ]),
  
      );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title :Row(
               children : <Widget>[ 
                 SizedBox(width: 20.0),
              Text(
              "Wind Power",
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
               
         
      // Set the nav drawer
      drawer: getNavDrawer(context)
    );
  }
}
