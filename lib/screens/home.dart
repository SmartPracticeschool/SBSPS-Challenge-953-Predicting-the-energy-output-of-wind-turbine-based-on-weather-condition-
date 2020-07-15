import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'account.dart';
import 'settings.dart';
import 'power.dart';

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
                  image: AssetImage("assets/wind-turbine.png"),
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
      getNavItem(Icons.arrow_right,Colors.lightBlue[300],"Weather Now", PowerScreen.routeName),
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

  Material MyItems(IconData icon,String heading, Color clr, String s ) {
    return Material(
      color: Colors.white,
      elevation: 14.0,
      shadowColor: Colors.lightBlueAccent[400],
      borderRadius: BorderRadius.circular(24.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children:<Widget>[
          Row(
          mainAxisAlignment : MainAxisAlignment.center,
              children:<Widget>[
           Padding(
              padding: const EdgeInsets.all(8.0),
          child: Text(heading,
            style: TextStyle(
              color: clr,
              fontSize: 18.0,
            ),
          ),
        ),
        Material(

            color: clr,
            borderRadius: BorderRadius.circular(24.0),
            child: Padding(
        padding: const EdgeInsets.all(16.0),
              child: Icon(icon),

      ),
    ),
    ]
    ),
                Text(
                  s,style:TextStyle(fontFamily: 'Montserrat',
                  fontSize: 18,
                  color: Colors.black,
                )
                )
    ]
    )
    )
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title:Row(
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
          backgroundColor: Colors.lightBlueAccent[700],
          elevation: 0.0,
        ),


      body: Stack(
         children:[
           Container(
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
           StaggeredGridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
        children: [

          MyItems(Icons.flash_on,"The power output",Colors.lightBlue[700],"For accurate power output, the wind speed and direction are predicted using our deep learning model and the values are used in the turbine power equation."),
          MyItems(Icons.toys,"Wind Farm",Colors.lightBlue[400],"The model is trained on weather data from Muppandal located in Kanyakumari, Tamil Nadu, India."),
          MyItems(Icons.format_align_justify,"The Model",Colors.lightBlue[400],"A Deep Learning Model built using LSTMs and is made compact so as to run on an application."),
        ],

        staggeredTiles:[
          StaggeredTile.extent(2,300.0),
          StaggeredTile.extent(1,300.0),
          StaggeredTile.extent(1,300.0),
        ],
      )]),
        drawer: getNavDrawer(context)
      );


      // Set the nav drawer

  }
}
