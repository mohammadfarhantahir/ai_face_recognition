

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ai_face/const/globals.dart' as globals;



void dialogAlerts(BuildContext context) {

  showDialog(
    context: context,
    builder: (BuildContext context) {

      return AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
       // title: new Text("Alert Dialog title"),
        content:  Container(
          child: Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child:Container(
                height: MediaQuery.of(context).size.height/3,
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
                child: Column(
                  children: [
                   Padding(
                     padding: EdgeInsets.fromLTRB(0, 20, 20, 0),

                     child:  Row(
                       mainAxisAlignment: MainAxisAlignment.end,
                       children: [
                         GestureDetector(
                             onTap: () {
                               print('cancel clicked');

                               Navigator.pop(context);

                             },
                             child:  Icon(Icons.cancel,color: Colors.white,size: 30,)
                         )
                       ],
                     ),
                   ),
                    SizedBox(
                      height: 20,
                    ),
                   Padding(
                     padding: EdgeInsets.fromLTRB(10, 10, 10, 10),

                     child:  Text('Oops!\nFace not found in this image',style: GoogleFonts.gruppo(fontSize: 28,color: Colors.white,fontWeight: FontWeight.bold)),
                   )
                  ],
                )
              )
          ),
        )
      );
    },
  );
}

