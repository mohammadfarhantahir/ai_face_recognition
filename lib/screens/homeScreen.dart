

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/curve_wave.dart';
 AnimationController? _controller;
class homeScreen extends StatefulWidget{
  State<homeScreen> createState()=> homeScreenState();
}

class homeScreenState extends State<homeScreen>with TickerProviderStateMixin{

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      lowerBound: 0.5,
      duration: Duration(seconds: 3),
    )..repeat();
  }
  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black,
              ), //BoxDecoration
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.black),
                accountName: Text(
                  "NiGELLA SOFTWARES",
                  style: TextStyle(fontSize: 18),
                ),
                accountEmail: Text("nigellainfotech.com@gmail.com"),
                currentAccountPictureSize: Size.square(50),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Color(0xFFE8E7E8),
                  child: Text(
                    "N",
                    style: TextStyle(fontSize: 30.0, color: Colors.blue),
                  ), //Text
                ), //circleAvatar
              ), //UserAccountDrawerHeader
            ), //DrawerHeader
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text(' My Profile '),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('LogOut'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ), //Deawer,
      body:  Stack(
        children: [
         Container(
           color: Colors.black,
           height: MediaQuery.of(context).size.height,
           width: MediaQuery.of(context).size.width,
           child: Column(
             children: [
               Expanded(
                 flex: 1,
                   child: Padding(
                     padding: EdgeInsets.fromLTRB(0, 50, 0, 50),
                     child: AnimatedBuilder(
                       animation: CurvedAnimation(parent: _controller!, curve: Curves.fastOutSlowIn),
                       builder: (context, child) {
                         return Stack(
                           alignment: Alignment.center,
                           children: <Widget>[
                             _buildneumorphism(120 * _controller!.value),
                             _buildneumorphism(180 * _controller!.value),
                             _buildneumorphism(200 * _controller!.value),
                             _buildneumorphism(240 * _controller!.value),
                             _buildneumorphism(300 * _controller!.value),
                             Align(child: Icon(Icons.wifi, size: 44,color: Colors.black,)),
                             Column(
                               mainAxisAlignment: MainAxisAlignment.end,
                               children: [
                                 Padding(
                                     padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
                                   child: Text('Wifi Signal',style: GoogleFonts.tomorrow(fontSize: 20,fontWeight: FontWeight.bold),),
                                 )
                               ],
                             )
                           ],
                         );
                       },
                     ),
                   )
                   ),
               Expanded(
                 flex: 1,
                   child: Container(
                     //height: MediaQuery.of(context).size.height/4,
                     color: Colors.orange,
                   ),),
               Expanded(
                 flex: 1,
                   child: Container(
                    // height: MediaQuery.of(context).size.height/4,
                     color: Colors.pink,
                   ))



             ],
           ),
         )
        ],
      )
    );
  }


}

Widget _buildContainer(double radius) {
  return Container(
    width: radius,
    height: radius,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Color(0xFFE8E7E8).withOpacity(1 - _controller!.value),
    ),
  );
}

Widget _buildneumorphism(double radius){
  return Container(
    width: radius,
    height: radius,
    decoration: BoxDecoration(

      boxShadow: [
        BoxShadow(
          color: Colors.white.withOpacity(0.8),
          offset: Offset(-6.0, -6.0),
          blurRadius: 10.0,

        ),
        BoxShadow(

          color: Colors.black.withOpacity(0.1),
          offset: Offset(6.0, 6.0),
          blurRadius: 10.0,
        ),
      ],
     /* color: Color(0xFFEFEEEE),
      borderRadius: BorderRadius.circular(12.0),*/
      shape: BoxShape.circle,
      color: Color(0xFFE8E7E8).withOpacity(1 - _controller!.value),


    ),
  );
}