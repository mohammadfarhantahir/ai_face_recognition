

import 'dart:async';


import 'package:ai_face/screens/verifyFrontcamera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:ai_face/const/globals.dart' as globals;


import 'enrollment.dart';
import 'face_found_History.dart';
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
       title: Text("Configure URL",style: GoogleFonts.didactGothic(fontSize: 28,color: Colors.white,fontWeight: FontWeight.bold)),
       content: Text("Please Enter i.p of OFFLINE server/system.",style: GoogleFonts.didactGothic(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white,),),
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
         child: Text("I Understand",style: GoogleFonts.didactGothic(fontSize: 18,color: Colors.white)),
       ),
     );


     // set up the AlertDialog
     AlertDialog alert = AlertDialog(
       backgroundColor: Colors.black,
       title: Text("Ooops!",style: GoogleFonts.didactGothic(fontSize: 28,color: Colors.white,fontWeight: FontWeight.bold)),
       content: Text("Its seems that you haven\'t configured the I.P yet\nGo to left side menu bar and choose \'CONFIGURE URL\'",style: GoogleFonts.didactGothic(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white,),),
       actions: [
         Column(
           mainAxisSize: MainAxisSize.max,

           children: [

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




   void _doPinging(){
     if(globals.readIPURL==null){
       print(' shared pref is empty');
       wifistatus = false;
       setState(() {


         _controller!.dispose();
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



  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

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
      periodicSub = new Stream.periodic(const Duration(milliseconds: 500), (v) => v)
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
              leading: const Icon(CupertinoIcons.settings),
              title: const Text(' Configure URL '),
              onTap: () {

                Navigator.pop(context);
                showAlertDialogForURL(context);
              },
            ),
            ExpansionTile(
              title: Text("History"),
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.face),
                  title: const Text('Verification History'),
                  onTap: () async {

                    Navigator.pop(context);
                    movetofacefoundhistory(context);
                  },
                ),

              ],
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('LogOut'),
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                //Remove String
                prefs.remove("ipURL");
                print('shared preference removed');
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
                                Icon(Icons.wifi_off, size: 34,color: Colors.black,)
                                ),
                                Positioned(
                                    top: MediaQuery.of(context).size.height/5,
                                    child:Center(
                                      child: wifistatus ? FittedBox(
                                        fit: BoxFit.fitWidth,
                                        child:Text('Connected..',style: GoogleFonts.didactGothic(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white)
                                          ,)):
                            FittedBox(
                            fit: BoxFit.fitWidth,
                            child:Text('Not Connected..',style: GoogleFonts.didactGothic(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),
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
                                                      child: FittedBox(
                                                        fit: BoxFit.fitWidth,
                                                        child: Text('Enroll Face',style: GoogleFonts.didactGothic(color: Colors.white,fontWeight: FontWeight.bold),
                                                        ),
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
                                                      child:  FittedBox(
                                                        fit: BoxFit.contain,
                                                        child:Text('Verify using\nFront camera',style: GoogleFonts.didactGothic(color: Colors.white,fontWeight: FontWeight.bold),),
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
                                              Text('Verify using\nBack camera',style: GoogleFonts.didactGothic(fontSize:18,color: Colors.white,fontWeight: FontWeight.bold),
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
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => enrollment()));
}
void movetofrontcamera(BuildContext context){
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => verifyFrontCamera()));

}

void  movetobackcamera(BuildContext context){
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => backCamera()));

}

void movetofacefoundhistory(BuildContext context){
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => facFoundHistory()));

}