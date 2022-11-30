

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'homeScreen.dart';

class loginScreenMain extends StatefulWidget{

  State<loginScreenMain> createState()=> loginScreenState();
}

class loginScreenState extends State<loginScreenMain>{
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
        top: MediaQuery.of(context).size.height/3,
        right: 10,
        left: 10,
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FittedBox(
            fit: BoxFit.fitWidth,
            child:
            Text('Login',style: GoogleFonts.gruppo(fontSize: 38,color: Colors.white,fontWeight: FontWeight.bold)
              ,),),
            SizedBox(
              height: 20,
            ),
            Container(

              width: MediaQuery.of(context).size.width/1.2,
              height: 70,
              padding: EdgeInsets.all(8),
              child: Center(
                  child:  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      style: GoogleFonts.didactGothic(fontSize: 18,color: Colors.black),
                      //keyboardType: TextInputType.numberWithOptions(),
                     // controller: urlController,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      //  hintText: 'Email',
                       // hintStyle: GoogleFonts.didactGothic(fontSize: 18,color: Colors.black),

                        border: InputBorder.none,
                        labelText: 'Email',
                        labelStyle: GoogleFonts.didactGothic(fontSize: 18,color: Colors.black),
                      ),
                      onChanged: (text) {

                      },
                    ),
                  )
              ),
              decoration: BoxDecoration(
                  color: Color(0xFFE8E8E9),
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    const BoxShadow(
                      color: Color(0xFF0052EE),
                      offset: Offset(2, 2),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                    const BoxShadow(
                      color: Color(0xFF0052EE),
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
            Container(

              width: MediaQuery.of(context).size.width/1.2,
              height: 70,
              padding: EdgeInsets.all(8),
              child: Center(
                  child:  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      style: GoogleFonts.didactGothic(fontSize: 18,color: Colors.black),
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      // controller: urlController,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                       // hintText: 'Password',
                       // hintStyle: GoogleFonts.didactGothic(fontSize: 18,color: Colors.black),

                        border: InputBorder.none,
                        labelText: 'Password',
                        labelStyle: GoogleFonts.didactGothic(fontSize: 18,color: Colors.black),
                      ),
                      onChanged: (text) {

                      },
                    ),
                  )
              ),
              decoration: BoxDecoration(
                  color: Color(0xFFE8E8E9),
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    const BoxShadow(
                      color: Color(0xFF0052EE),
                      offset: Offset(2, 2),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                    const BoxShadow(
                      color: Color(0xFF0052EE),
                      offset: Offset(-2, -2),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ]
              ),
            ),
            SizedBox(height: 50,),
            GestureDetector(
              onTap: () {
                print('login clicked');
                movetoHomescreen(context);
              },
              child: Container(
                width: MediaQuery.of(context).size.width/1.5,
                height: 60,
                padding: EdgeInsets.all(8),
                child: Center(
                  child: Text('Login',style: GoogleFonts.didactGothic(fontSize: 18,color: Colors.black),),
                ),
                decoration: BoxDecoration(
                    color: Color(0xFFE8E8E9),
                    borderRadius: BorderRadius.circular(15),
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

          ]
        )
      )


          ],

        ),
      ),
    );
  }


}

void movetoHomescreen(BuildContext context){
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => homeScreen()));
}
