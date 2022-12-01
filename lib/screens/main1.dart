

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'homeScreen.dart';
import 'loginScreen.dart';

class loginScreen extends StatefulWidget{
  @override
  State<loginScreen> createState()=> loginScreenState();
}

class loginScreenState extends State<loginScreen>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child:  Image.asset("assets/images/main.jpg",fit: BoxFit.cover,),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height/2,
              right: 10,
              left: 10,
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                FittedBox(
                fit: BoxFit.fitWidth,
                child:
                  Text('SWIMS-BIO\nFace Recognition System',style: GoogleFonts.gruppo(fontSize: 38,color: Colors.white,fontWeight: FontWeight.bold),
                  ),),
                  SizedBox(
                    height: 20,
                  ),
              FittedBox(
                fit: BoxFit.fitWidth,
                child:Text('Enrolled, Verify, Relax.',style: GoogleFonts.gruppo(fontSize: 28,color: Colors.white,fontWeight: FontWeight.normal),
                ),),
                  SizedBox(
                    height: 20,
                  ),

                  GestureDetector(
                    onTap: () {
                      print('login clicked');
                      movetoHomescreen(context);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width/1.2,
                      height: 70,
                      padding: EdgeInsets.all(8),
                      child: Center(
                        child:FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text('Login',style: GoogleFonts.didactGothic(fontSize: 18,color: Colors.black)
                            ,),
                        )
                      ),
                      decoration: BoxDecoration(
                          color: Color(0xFFE8E8E9),
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            const BoxShadow(
                              color: Color(0xFF0052EE),
                              offset: Offset(2, 2),
                              blurRadius: 10,
                              spreadRadius: 1,
                            ),
                            const BoxShadow(
                              color: Color(0xFF437CED),
                              offset: Offset(-2, -2),
                              blurRadius: 10,
                              spreadRadius: 1,
                            ),
                          ]
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      print('how to use clicekd');
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width/1.2,
                      height: 70,
                      padding: EdgeInsets.all(8),
                      child: Center(
                        child:FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text('How to use?',style: GoogleFonts.didactGothic(fontSize: 18,color: Colors.black),),
                        )
                      ),
                      decoration: BoxDecoration(
                          color: Color(0xFFE8E8E9),
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            const BoxShadow(
                              color: Color(0xFF0052EE),
                              offset: Offset(2, 2),
                              blurRadius: 10,
                              spreadRadius: 1,
                            ),
                            const BoxShadow(
                              color: Color(0xFF437CED),
                              offset: Offset(-2, -2),
                              blurRadius: 10,
                              spreadRadius: 1,
                            ),
                          ]
                      ),
                    ),

                  )


                ],
              ),//CircularAvatar
            ),
          ],

        ),
      )

    );
  }


}

// to navigate
void movetoHomescreen(BuildContext context){
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => loginScreenMain()));
}

