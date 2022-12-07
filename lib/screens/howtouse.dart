



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'main1.dart';

class howtouse extends StatefulWidget{

  State<howtouse> createState()=> howtouseState();
}

class howtouseState extends State<howtouse>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: Text("How to use?",style: GoogleFonts.gruppo(fontSize: 28,color: Colors.white,fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => movetoback(context),

        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,

        child: SingleChildScrollView(
            child: Padding(
    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
    child: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 10,
          ),

          Container(
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
              child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      unselectedWidgetColor: Colors.white, // here for close state
                      colorScheme: ColorScheme.light(
                        primary: Colors.white,
                      ), // here for open state in replacement of deprecated accentColor
                      dividerColor: Colors.transparent, // if you want to remove the border
                    ),
                    child: ExpansionTile(

                      collapsedIconColor: Colors.white,
                      iconColor: Colors.white,
                      title: Text(
                          'What is SWIMS-BIO AI face recognition?',style: GoogleFonts.gruppo(fontSize: 28,color: Colors.white,fontWeight: FontWeight.bold)
                      ),
                      children: <Widget>[
                        ListTile(
                          title: Text(
                              'Ans - swims-bio is a high quality AI face recognition systems build by NiGELLA SOFTWARES. this A.I used to verify mass testing of human face which is already registered in our system. If a person FACE is registered in our system,the system can identify that person by just a click away.and in-case if the person is not registered in our system and user wants to check then in that scenario it will give the results as not found. Long story short user can verify person face is registered with SWIMS-BIO AI FACE RECOGNITION service or not.'
                              ,style: GoogleFonts.gruppo(fontSize: 28,color: Colors.white,fontWeight: FontWeight.normal)
                          ),
                        )
                      ],
                    ),
                  )



              )
          ),


          SizedBox(
            height: 20,
          ),


          Container(
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
              child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      unselectedWidgetColor: Colors.white, // here for close state
                      colorScheme: ColorScheme.light(
                        primary: Colors.white,
                      ), // here for open state in replacement of deprecated accentColor
                      dividerColor: Colors.transparent, // if you want to remove the border
                    ),
                    child: ExpansionTile(

                      title: Text(
                          'Is it available in offline or online mode?',style: GoogleFonts.gruppo(fontSize: 28,color: Colors.white,fontWeight: FontWeight.bold)
                      ),
                      children: <Widget>[
                        ListTile(
                          title: Text(
                              'Ans- yes, just login with the credentials and go to the left side menu and select the option "configure url" put the i.p address of your offline server and start verifying. 😊'
                              ,style: GoogleFonts.gruppo(fontSize: 28,color: Colors.white,fontWeight: FontWeight.normal)
                          ),
                        )
                      ],
                    ),
                  )



              )
          ),


          SizedBox(
            height: 20,
          ),

          Container(
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
              child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      unselectedWidgetColor: Colors.white, // here for close state
                      colorScheme: ColorScheme.light(
                        primary: Colors.white,
                      ), // here for open state in replacement of deprecated accentColor
                      dividerColor: Colors.transparent, // if you want to remove the border
                    ),
                    child: ExpansionTile(
                      title: Text(
                          'How to do verification?',style: GoogleFonts.gruppo(fontSize: 28,color: Colors.white,fontWeight: FontWeight.bold)
                      ),
                      children: <Widget>[
                        ListTile(
                          title: Text(
                              'Ans - The app is so simple, just login with the given credentials, go to dashboard and click on any button i.e., "verify with front camera" or verify with back camera" . Click the image of persons face and chill , now rest of the critical things will be done by SWIMS-BIO AI . If the person is registered it will give you the details like name,id* with tags like "FOUND" and "NOT FOUND" .Along with the taken image.'
                              ,style: GoogleFonts.gruppo(fontSize: 28,color: Colors.white,fontWeight: FontWeight.normal)
                          ),
                        )
                      ],
                    ),
                  )



              )
          ),

          SizedBox(
            height: 20,
          ),


          Container(
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
              child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      unselectedWidgetColor: Colors.white, // here for close state
                      colorScheme: ColorScheme.light(
                        primary: Colors.white,
                      ), // here for open state in replacement of deprecated accentColor
                      dividerColor: Colors.transparent, // if you want to remove the border
                    ),
                    child: ExpansionTile(
                      title: Text(
                          ' what will happen if users take no-human face?\nWill it work ?',style: GoogleFonts.gruppo(fontSize: 28,color: Colors.white,fontWeight: FontWeight.bold)
                      ),
                      children: <Widget>[
                        ListTile(
                          title: Text(
                              'Ans- the app is capable of detecting human face and other objects. In case the capture image is not of human face it will give you the results as "NO FACE FOUND IN THIS IMAGE" thanks to the NiGELLA SOFTWARES AI technology.'
                              ,style: GoogleFonts.gruppo(fontSize: 28,color: Colors.white,fontWeight: FontWeight.normal)
                          ),
                        )
                      ],
                    ),
                  )



              )
          ),

          SizedBox(
            height: 20,
          ),

          Container(
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
              child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      unselectedWidgetColor: Colors.white, // here for close state
                      colorScheme: ColorScheme.light(
                        primary: Colors.white,
                      ), // here for open state in replacement of deprecated accentColor
                      dividerColor: Colors.transparent, // if you want to remove the border
                    ),
                    child: ExpansionTile(
                      title: Text(
                          'How good is camera quality?',style: GoogleFonts.gruppo(fontSize: 28,color: Colors.white,fontWeight: FontWeight.bold)
                      ),
                      children: <Widget>[
                        ListTile(
                          title: Text(
                              'Ans- well, the app is designed by keeping in mind that the app can be used in any situations like it can be used in DAY and NIGHT so the SWIMS-BIO app camera is also fully automatic packed , meaning camera will auto flash as per the background scenes. Also the app includes features like zoom-in/out, brightness high -low, and camera picture quality from LOW to ULTRAMAX .So no more hassle in taking pictures and verification.'
                              ,style: GoogleFonts.gruppo(fontSize: 28,color: Colors.white,fontWeight: FontWeight.normal)
                          ),
                        )
                      ],
                    ),
                  )



              )
          ),

          SizedBox(
            height: 20,
          ),


          Container(
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
              child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      unselectedWidgetColor: Colors.white, // here for close state
                      colorScheme: ColorScheme.light(
                        primary: Colors.white,
                      ), // here for open state in replacement of deprecated accentColor
                      dividerColor: Colors.transparent, // if you want to remove the border
                    ),
                    child:ExpansionTile(
                      title: Text(
                          'What will happen if i broke my phone/device or my phone/device is stolen?',style: GoogleFonts.gruppo(fontSize: 28,color: Colors.white,fontWeight: FontWeight.bold)
                      ),
                      children: <Widget>[
                        ListTile(
                          title: Text(
                              'No more worries of internal storage, no more worries in scenario like phone is broken/lost/dead. As SWIMS-BIO app work on internet connection and uses the world class high security on server so that\'s mean your data are secured with us and no more storing the data over local device. So in case you\'ve lost your phone or God forbid if your phone is stolen,just relax download the app from playstore or app Store as (per your need) and login with the credentials given to you and woolah you\'re back with your data , verification and other services provided by SWIMS-BIO.'
                              ,style: GoogleFonts.gruppo(fontSize: 28,color: Colors.white,fontWeight: FontWeight.normal)
                          ),
                        )
                      ],
                    ),
                  )



              )
          ),

          SizedBox(
            height: 20,
          ),

        ],
      ),
    ),
            ),
        ),
    )
    );
  }

}

void movetoback(BuildContext context){
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => loginScreen()));
}