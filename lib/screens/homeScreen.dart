

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/curve_wave.dart';

bool wifistatus = false;
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
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
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
                wifistatus = true;
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('LogOut'),
              onTap: () {
                wifistatus = false;
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ), //Deawer,
      body:  SingleChildScrollView(
        child: Stack(
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
                        padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height/50, 0, 10),
                        child: AnimatedBuilder(
                          animation: CurvedAnimation(parent: _controller!, curve: Curves.fastOutSlowIn),
                          builder: (context, child) {
                            return Stack(
                              alignment: Alignment.center,
                              children: <Widget>[

                                _buildneumorphism(120 * _controller!.value),
                                _buildneumorphism(180 * _controller!.value),
                                _buildneumorphism(200 * _controller!.value),
                                _buildneumorphism(220 * _controller!.value),
                                _buildneumorphism(260 * _controller!.value),
                                Align(child: wifistatus ? Icon(Icons.wifi, size: 34,color: Colors.white,):
                                Icon(Icons.wifi, size: 34,color: Colors.black,)
                                ),
                                Positioned(
                                    top: MediaQuery.of(context).size.height/5,
                                    child:Center(
                                      child: wifistatus ? Text('Connected..',style: GoogleFonts.didactGothic(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),):
                                      Text('Not Connected..',style: GoogleFonts.didactGothic(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                                    )
                                )

                              ],
                            );
                          },
                        ),
                      )
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                    flex: 1,
                                    child:  Padding(
                                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                      child: GestureDetector(
                                        onTap: () {
                                          print('Enrolled clicekd');
                                        },
                                        child: Container(
                                          width: MediaQuery.of(context).size.width/1.2,
                                          height: 150,
                                          padding: EdgeInsets.all(8),
                                          child: Center(
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                      flex: 1,
                                                      child: Icon(CupertinoIcons.profile_circled,color: Colors.white)),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Text('Enroll Face',style: GoogleFonts.didactGothic(fontSize: 18,color: Colors.white),),)
                                                ],
                                              )
                                          ),
                                          decoration: BoxDecoration(
                                              color: Color(0xFF000000),
                                              borderRadius: BorderRadius.circular(20),
                                              boxShadow: [
                                                const BoxShadow(
                                                  color: Color(0xFFffffff),
                                                  offset: Offset(2, 2),
                                                  blurRadius: 10,
                                                  spreadRadius: 1,
                                                ),
                                                const BoxShadow(
                                                  color: Color(0xFFffffff),
                                                  offset: Offset(-2, -2),
                                                  blurRadius: 10,
                                                  spreadRadius: 1,
                                                ),
                                              ]
                                          ),
                                        ),

                                      ),
                                    )
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                      child: GestureDetector(
                                        onTap: () {
                                          print('Verify front camera clicekd');
                                        },
                                        child: Container(
                                          width: MediaQuery.of(context).size.width/1.2,
                                          height: 150,
                                          padding: EdgeInsets.all(8),
                                          child: Center(
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                      flex:1,
                                                      child: Icon(CupertinoIcons.camera,color: Colors.white,)),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Text('Verify using front camera',style: GoogleFonts.didactGothic(fontSize: 18,color: Colors.white),),)
                                                ],
                                              )
                                          ),
                                          decoration: BoxDecoration(
                                              color: Color(0xFF000000),
                                              borderRadius: BorderRadius.circular(20),
                                              boxShadow: [
                                                const BoxShadow(
                                                  color: Color(0xFFffffff),
                                                  offset: Offset(2, 2),
                                                  blurRadius: 10,
                                                  spreadRadius: 1,
                                                ),
                                                const BoxShadow(
                                                  color: Color(0xFFffffff),
                                                  offset: Offset(-2, -2),
                                                  blurRadius: 10,
                                                  spreadRadius: 1,
                                                ),
                                              ]
                                          ),
                                        ),

                                      ),
                                    )
                                ),


                              ],
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                      child: GestureDetector(
                                        onTap: () {
                                          print('Back camera clicekd');
                                        },
                                        child: Container(
                                          width: MediaQuery.of(context).size.width/1.2,
                                          height: 150,
                                          padding: EdgeInsets.all(8),
                                          child: Center(
                                              child: Row(
                                                children: [
                                                  Expanded(child: Icon(CupertinoIcons.camera,color: Colors.white,)),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Text('Verify using back camera',style: GoogleFonts.didactGothic(fontSize: 18,color: Colors.white),),)
                                                ],
                                              )
                                          ),
                                          decoration: BoxDecoration(
                                              color: Color(0xFF000000),
                                              borderRadius: BorderRadius.circular(20),
                                              boxShadow: [
                                                const BoxShadow(
                                                  color: Color(0xFFffffff),
                                                  offset: Offset(2, 2),
                                                  blurRadius: 10,
                                                  spreadRadius: 1,
                                                ),
                                                const BoxShadow(
                                                  color: Color(0xFFffffff),
                                                  offset: Offset(-2, -2),
                                                  blurRadius: 10,
                                                  spreadRadius: 1,
                                                ),
                                              ]
                                          ),
                                        ),

                                      ),
                                    )
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    flex: 1,
                                    child:  Padding(
                                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                      child: GestureDetector(
                                        onTap: () {
                                          print('About us clicekd');
                                        },
                                        child: Container(
                                          width: MediaQuery.of(context).size.width/1.2,
                                          height: 150,
                                          padding: EdgeInsets.all(8),
                                          child: Center(
                                              child:Row(
                                                children: [
                                                  Expanded(
                                                      flex: 1,
                                                      child:Icon(Icons.info,color: Colors.white,) ),
                                                  Expanded(
                                                    flex: 2,
                                                    child:  Text('About us',style: GoogleFonts.didactGothic(fontSize: 18,color: Colors.white),),)
                                                ],
                                              )
                                          ),
                                          decoration: BoxDecoration(
                                              color: Color(0xFF000000),
                                              borderRadius: BorderRadius.circular(20),
                                              boxShadow: [
                                                const BoxShadow(
                                                  color: Color(0xFFffffff),
                                                  offset: Offset(2, 2),
                                                  blurRadius: 10,
                                                  spreadRadius: 1,
                                                ),
                                                const BoxShadow(
                                                  color: Color(0xFFffffff),
                                                  offset: Offset(-2, -2),
                                                  blurRadius: 10,
                                                  spreadRadius: 1,
                                                ),
                                              ]
                                          ),
                                        ),

                                      ),
                                    )
                                ),


                              ],
                            )
                          ],
                        ),
                      )
                  ),

                  SizedBox(
                    height: 20,
                  ),



                ],
              ),
            ),

          ],
        ),
      )

    );
  }


}


Widget _buildneumorphism(double radius){
  return Container(
    width: radius,
    height: radius,
    decoration: BoxDecoration(

      boxShadow: [
        BoxShadow(
          color: wifistatus ? Colors.green.withOpacity(0.8): Colors.red.withOpacity(0.8),
          offset: Offset(-6.0, -6.0),
          blurRadius: 16.0,

        ),
        BoxShadow(

          color: Colors.greenAccent.withOpacity(0.1),
          offset: Offset(6.0, 6.0),
          blurRadius: 16.0,
        ),
      ],
     /* color: Color(0xFFEFEEEE),
      borderRadius: BorderRadius.circular(12.0),*/
      shape: BoxShape.circle,
      color: Color(0xFFE8E7E8).withOpacity(1 - _controller!.value),


    ),
  );
}
