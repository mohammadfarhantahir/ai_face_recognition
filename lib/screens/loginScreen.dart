

import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/dialogAlerts.dart';
import 'homeScreen.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:ai_face/const/globals.dart' as globals;


final usernamenameController = TextEditingController();
final passwordController = TextEditingController();
class loginScreenMain extends StatefulWidget{

  State<loginScreenMain> createState()=> loginScreenState();
}



class loginScreenState extends State<loginScreenMain>{



  addStringToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('username', usernamenameController.text.toString());
    });

  }

  void login(String username , password) async {

    try{

      Response response = await get(
        Uri.parse('http://'+globals.readIPURL!+'/face-recognition-webservice-master/mobilelogin.php?username='+usernamenameController.text.toString()+'&&password='+passwordController.text.toString()),


      );

      print(response.body);
      if(response.statusCode == 200){

        var data = jsonDecode(response.body.toString());
        print(data.toString());
        if(data.toString()=='Login Matched'){
          setState(() {
            addStringToSF();
            movetoHomescreen(context);
            print('now can move to dashboard');
          });

        }
        else{
          setState(() {
            dialogAlertslforlogin(context);
            print('invalid username and password');
          });

        }


      }else {
        print('failed');
      }
    }catch(e){
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(



      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black87,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.settings,
            ),
            // the method which is called
            // when button is pressed
            onPressed: () {
              setState(
                    () {
                      dialogAlertslforloginsetup(context);
                  print('url setting clicked');
                },
              );
            },
          ),
        ],

      ),

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
            AutoSizeText('Login',style: GoogleFonts.gruppo(fontSize: 38,color: Colors.white,fontWeight: FontWeight.bold)
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
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: TextField(
                      cursorColor: Colors.black,
                      textInputAction: TextInputAction.unspecified,
                      style: GoogleFonts.didactGothic(fontSize: 18,color: Colors.black),
                      //keyboardType: TextInputType.numberWithOptions(),
                      controller: usernamenameController,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      //  hintText: 'Email',
                       // hintStyle: GoogleFonts.didactGothic(fontSize: 18,color: Colors.black),

                        border: InputBorder.none,
                        labelText: 'Email',
                        labelStyle: GoogleFonts.gruppo(fontSize: 18,color: Colors.black),
                      ),

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
                      cursorColor: Colors.black,
                      style: GoogleFonts.didactGothic(fontSize: 18,color: Colors.black),
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                       controller: passwordController,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                       // hintText: 'Password',
                       // hintStyle: GoogleFonts.didactGothic(fontSize: 18,color: Colors.black),

                        border: InputBorder.none,
                        labelText: 'Password',
                        labelStyle: GoogleFonts.gruppo(fontSize: 18,color: Colors.black),
                      ),

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
                if(usernamenameController.text.toString().isEmpty || passwordController.text.toString().isEmpty){
                  print('cannot be empty');
                  dialogAlertslforloginempty(context);
                }else{

                  Socket.connect(globals.readIPURL, 80, timeout: Duration(seconds: 5)).then((socket){

                    setState(() {
                      print('php i.p is ---->'+globals.readIPURL!);

                      globals.username = usernamenameController.text.toString();
                      globals.password = passwordController.text.toString();
                      login(usernamenameController.text.toString(),passwordController.text.toString());

                      // wifistatus = true;


                      print("Success");
                    });


                    socket.destroy();
                  }).catchError((error){
                    setState(() {

                      dialogAlertslforiperror(context);
                      print("Exception on Socket "+error.toString());

                    });

                  });


                }

                //movetoHomescreen(context);
              },
              child: Container(
                width: MediaQuery.of(context).size.width/1.5,
                height: 60,
                padding: EdgeInsets.all(8),
                child: Center(
                  child: AutoSizeText('Login',style: GoogleFonts.gruppo(fontSize: 18,color: Colors.black),),
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
 // Navigator.of(context).push(MaterialPageRoute(builder: (context) => homeScreen()));
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
          builder: (context) => homeScreen()
      ),
      ModalRoute.withName("/homescreen")
  );
 /* Navigator.pushReplacementNamed(context, '/homescreen');
      (route) => false;*/
}
