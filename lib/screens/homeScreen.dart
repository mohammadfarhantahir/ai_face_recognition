

import 'dart:async';


import 'package:ai_face/screens/verifyFrontcamera.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:ai_face/const/globals.dart' as globals;
import 'package:flutter/foundation.dart' show kIsWeb;

import 'enrollment.dart';
import 'face_found_History.dart';
import 'loginScreen.dart';
import 'main1.dart';
import 'verifyBackcamera.dart';

bool wifistatus = false;
String connectionStatus='';

AnimationController? _controller;

class homeScreen extends StatefulWidget{
  State<homeScreen> createState()=> homeScreenState();
}

class homeScreenState extends State<homeScreen>with TickerProviderStateMixin{

   StreamSubscription? periodicSub;


   // WRITE shared preferences for storing I.P
   addStringToSF() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     setState(() {
       prefs.setString('ipURL', urlController.text);
     });

   }


   // READ shared preferences for getting the value of I.P
   getStringValuesSF() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     //Return String
     globals.readIPURL= prefs.getString('ipURL');

     _doPinging();



     return globals.readIPURL;
   }

   TextEditingController urlController = TextEditingController();
   showAlertDialogForURL(BuildContext context) {

     // textfield for url
     // set up the buttons
     Widget cancelButton = TextButton(
       child: Text("Cancel",style: GoogleFonts.didactGothic(fontSize: 18,color: Colors.white)),
       onPressed:  () {
         Navigator.pop(context);
       },
     );
     Widget continueButton = TextButton(
       child: Text("Continue",style: GoogleFonts.didactGothic(fontSize: 18,color: Colors.white)),
       onPressed:  () {
         setState(() {
           globals.readIPURL = urlController.text;
           _doPinging();
           print('ip value is -->'+globals.readIPURL!);
           addStringToSF();
           //  ();
           print('continue of alert clicked');
           Navigator.pop(context);

         });
         //

       },
     );


     // set up the AlertDialog
     AlertDialog alert = AlertDialog(
       backgroundColor: Colors.black,
       title: Text("Configure URL",style: GoogleFonts.gruppo(fontSize: 28,color: Colors.white)),
       content: Text("Please Enter i.p of OFFLINE server/system.",style: GoogleFonts.gruppo(fontSize: 28,color: Colors.white),),
       actions: [
         Column(
           mainAxisSize: MainAxisSize.max,

           children: [
             Container(

               width: MediaQuery.of(context).size.width/1.2,
               height: 70,
               padding: EdgeInsets.all(8),
               child: Center(
                   child:  Padding(
                     padding: EdgeInsets.all(10),
                     child: TextField(
                       style: GoogleFonts.didactGothic(fontSize: 18,color: Colors.white),
                       keyboardType: TextInputType.numberWithOptions(),
                       controller: urlController,
                       decoration: InputDecoration(


                         border: InputBorder.none,
                         labelText: 'I.p',
                       ),
                       onChanged: (text) {



                       },
                     ),
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
             SizedBox(
               height: 20,
             ),
             Row(
               mainAxisAlignment: MainAxisAlignment.end,
               children: [
                 Expanded(
                   flex: 1,
                   child: Container(
                     width: 200,
                     height: 70,
                     padding: EdgeInsets.all(8),
                     child: Center(
                       child:   cancelButton,
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
                   ),),
                 SizedBox(
                   width: 10,
                 ),
                 Expanded(
                   child:  Container(
                     width: 200,
                     height: 70,
                     padding: EdgeInsets.all(8),
                     child: Center(
                       child: continueButton,
                     ),
                     decoration: BoxDecoration(
                         color: Color(0xFFE000000),
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
                   ),)




               ],
             )
           ],
         ),



       ],
     );

     // show the dialog
     showDialog(
       context: context,
       builder: (BuildContext context) {
         return alert;
       },
     );
   }




   showAlertDialogNOTCONFIGURED(BuildContext context) {

     // textfield for url
     // set up the buttons
     Widget cancelButton =  GestureDetector(
       onTap: () {
         setState(() {
           print('OOPS clicked');
           Navigator.of(context, rootNavigator: true).pop();
         });

       },
       child:Container(
         child: Text("I Understand",style: GoogleFonts.gruppo(fontSize: 18,color: Colors.white)),
       ),
     );


     // set up the AlertDialog
     AlertDialog alert = AlertDialog(
       backgroundColor: Colors.black,
       title:  Container(
         height: MediaQuery.of(context).size.height/2,
         child: Padding(
           padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             mainAxisSize: MainAxisSize.max,

             children: [
               Container(
                 height: 30,
                 child: Text("Ooops!",style: GoogleFonts.gruppo(fontSize: 28,color: Colors.white,fontWeight: FontWeight.bold)),
               ),
               SizedBox(
                 height: 20,
               ),
               Container(
                 height: 100,
                 child:  Text("Its seems that you haven\'t configured the I.P yet\nGo to left side menu bar and choose \'CONFIGURE URL\'",style: GoogleFonts.gruppo(fontSize: 28,color: Colors.white,fontWeight: FontWeight.bold),),
               ),


               SizedBox(
                 height: 20,
               ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.end,
                 children: [
                   Expanded(
                     flex: 1,
                     child: GestureDetector(
                       onTap: () {
                         setState(() {
                           print('Main button clicked');
                           Navigator.of(context, rootNavigator: true).pop();
                         });

                       },
                       child:
                     Container(
                       width: 200,
                       height: 70,
                       padding: EdgeInsets.all(8),
                       child: Center(
                         child:   Text("I Understand",style: GoogleFonts.didactGothic(fontSize: 18,color: Colors.white)),
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
                     )
                     ),
                   SizedBox(
                     width: 10,
                   ),




                 ],
               )
             ],
           ),
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

       )
       //

     );

     // show the dialog
     showDialog(
       barrierDismissible: false,
       context: context,
       builder: (BuildContext context) {
         return alert;
       },
     );
   }




   void _doPinging(){
     if(globals.readIPURL==null){
       print(' shared pref is empty');

       setState(() {
         wifistatus = false;


         showAlertDialogNOTCONFIGURED(context);
       });



     }
     else{
       Socket.connect(globals.readIPURL, 80, timeout: Duration(seconds: 5)).then((socket){

         setState(() {

           print('shared perefence value is--->'+globals.readIPURL!);
           wifistatus = true;


           // wifistatus = true;


           print("Success");
         });


         socket.destroy();
       }).catchError((error){
         setState(() {

           wifistatus = false;
           print("Exception on Socket "+error.toString());

         });

       });

     }

   }

   getStringValuesusername() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     //Return String
     String? stringValue = prefs.getString('username');
     globals.username = stringValue!;
     return stringValue;
   }


  @override
  void initState()  {
    getStringValuesusername();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    if (kIsWeb) {
      // running on the web!
      print('now running on web');
    } else {
      print('not running on web');
      // NOT running on the web! You can check for additional platforms here.
    }

    super.initState();

    getStringValuesSF();


    _controller = AnimationController(
      vsync: this,
      lowerBound: 0.5,
      duration: Duration(seconds: 3),
    )..repeat();
    if(globals.readIPURL==null){

    }
    else{
      _controller = AnimationController(
        vsync: this,
        lowerBound: 0.5,
        duration: Duration(seconds: 3),
      )..repeat();
      periodicSub = new Stream.periodic( Duration(milliseconds: 500), (v) => v)
          .take(1)
          .listen((count) =>getStringValuesSF());
    }


  }
  @override
  void dispose() {

    _controller!.dispose();
    periodicSub!.cancel();


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
             DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black,
              ), //BoxDecoration
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.black),
                accountName: AutoSizeText(
                  "SWIMS- BIO",
                  style: TextStyle(fontSize: 18),
                ),
                accountEmail: AutoSizeText(globals.username!),
                currentAccountPictureSize: Size.square(50),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Color(0xFFE8E7E8),
                  child: AutoSizeText(
                    "S",
                    style: TextStyle(fontSize: 30.0, color: Colors.blue),
                  ), //Text
                ), //circleAvatar
              ), //UserAccountDrawerHeader
            ), //DrawerHeader
            ListTile(
              leading: const Icon(CupertinoIcons.settings),
              title: const AutoSizeText(' Configure URL '),
              onTap: () {

                Navigator.pop(context);
                showAlertDialogForURL(context);
              },
            ),
            ExpansionTile(
              title: AutoSizeText("History"),
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.face),
                  title: const AutoSizeText('Verification History'),
                  onTap: () async {

                    Navigator.pop(context);
                    movetofacefoundhistory(context);
                  },
                ),

              ],
            ),


            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const AutoSizeText('Live Back Camera Capture'),
              onTap: () async {

                Navigator.pop(context);
                movetoLiveCapture(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const AutoSizeText('Live Front Camera Capture'),
              onTap: () async {

                Navigator.pop(context);
                movetoFrontCapture(context);
              },
            ),


            ListTile(
              leading: const Icon(Icons.logout),
              title: const AutoSizeText('LogOut'),
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                //Remove String
                prefs.remove("ipURL");

                prefs.remove('username');
                print('shared preference removed');
                Navigator.pop(context);
                movetomainscreen(context);
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
                                Icon(Icons.wifi_off, size: 34,color: Colors.black,)
                                ),
                                Positioned(
                                    top: MediaQuery.of(context).size.height/5,
                                    child:Center(
                                      child: wifistatus ? FittedBox(
                                        fit: BoxFit.fitWidth,
                                        child:Text('Connected..',style: GoogleFonts.gruppo(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold)
                                          ,)):
                            FittedBox(
                            fit: BoxFit.fitWidth,
                            child:Text('Not Connected..',style: GoogleFonts.gruppo(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold)
                            ),
                            )
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
                                          movetoenrollment(context);
                                          print('Enrolled clicekd');
                                        },
                                        child: Container(
                                          width: MediaQuery.of(context).size.width/1.2,
                                          height: 100,
                                          padding: EdgeInsets.all(8),
                                          child: Center(
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                      flex: 1,
                                                      child: Icon(CupertinoIcons.profile_circled,color: Colors.white)),
                                                  Expanded(
                                                    flex: 2,
                                                    child:Padding(
                                                      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                                      child: AutoSizeText('Enroll Face',style: GoogleFonts.gruppo(fontSize: 28,color: Colors.white,fontWeight: FontWeight.bold),
                                                      ),
                                                    )
                                                  )
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
                                          movetofrontcamera(context);
                                          print('Verify front camera clicekd');
                                        },
                                        child: Container(
                                          width: MediaQuery.of(context).size.width/1.2,
                                          height: 100,
                                          padding: EdgeInsets.all(8),
                                          child: Center(
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                      flex:1,
                                                      child: Icon(CupertinoIcons.camera,color: Colors.white,)),
                                                  Expanded(
                                                    flex: 2,
                                                    child:
                                                    Padding(
                                                      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                                      child:  AutoSizeText('Verify using\nFront camera',style: GoogleFonts.gruppo(fontSize: 28,color: Colors.white,fontWeight: FontWeight.bold),),
                                                    )
                                                  )
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
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: GestureDetector(
                                onTap: () {
                                  movetobackcamera(context);
                                  print('Back camera clicekd');
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width/1.2,
                                  height: 100,
                                  padding: EdgeInsets.all(8),
                                  child: Center(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex:1,
                                              child: Icon(CupertinoIcons.camera,color: Colors.white,)),
                                          Expanded(
                                              flex: 1,
                                              child:
                                              AutoSizeText('Verify using\nBack camera',style: GoogleFonts.gruppo(fontSize: 28,color: Colors.white,fontWeight: FontWeight.bold),


                                                ),
                                          )

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

void movetoenrollment(BuildContext context){
 // Navigator.of(context).push(MaterialPageRoute(builder: (context) => enrollment()));
  Navigator.pushNamed(context, '/enrollment');
}
void movetofrontcamera(BuildContext context){
 // Navigator.of(context).push(MaterialPageRoute(builder: (context) => verifyFrontCamera()));
  Navigator.pushNamed(context, '/verifyFrontCamera');

}

void  movetobackcamera(BuildContext context){
  //Navigator.of(context).push(MaterialPageRoute(builder: (context) => backCamera()));
  Navigator.pushNamed(context, '/backCamera');

}

void movetofacefoundhistory(BuildContext context){
  //Navigator.of(context).push(MaterialPageRoute(builder: (context) => facFoundHistory()));
  Navigator.pushNamed(context, '/facFoundHistory');

}
void movetomainscreen(BuildContext context){
  //Navigator.of(context).push(MaterialPageRoute(builder: (context) => loginScreen()));

  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
          builder: (context) => loginScreenMain()
      ),
      ModalRoute.withName("/loginscreen")
  );
 // Navigator.pushNamed(context, '/loginscreen');

}


void movetoLiveCapture(BuildContext context){
  //Navigator.of(context).push(MaterialPageRoute(builder: (context) => loginScreen()));
  Navigator.pushNamed(context, '/LiveCapture');

}

void movetoFrontCapture(BuildContext context){
  Navigator.pushNamed(context, '/FrontLiveCapture');

}