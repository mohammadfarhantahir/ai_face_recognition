

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ai_face/const/globals.dart' as globals;

import '../screens/idcardScanner.dart';



void dialogAlerts(BuildContext context) {

  showDialog(
    context: context,
    barrierDismissible: false,
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




void dialogAlertsEnrollmentFacefound(BuildContext context) {

  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {

      return AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          // title: new Text("Alert Dialog title"),
          content:  Container(
            height: MediaQuery.of(context).size.height/2,
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

                          child:  Text('Oops!\nThis person is already regisitered in our system\nplease contact ADMIN for more information',style: GoogleFonts.gruppo(fontSize: 28,color: Colors.white,fontWeight: FontWeight.bold)),
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




void dialogAlertsEnrollmentNamefound(BuildContext context) {

  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {

      return AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          // title: new Text("Alert Dialog title"),
          content:  Container(
            height: MediaQuery.of(context).size.height/2,
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

                          child:  Text('Oops!\nName already found in the system\nTry Other name',style: GoogleFonts.gruppo(fontSize: 28,color: Colors.white,fontWeight: FontWeight.bold)),
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




void dialogAlertsEnrollmentMorethen1face(BuildContext context) {

  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {

      return AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          // title: new Text("Alert Dialog title"),
          content:  Container(
            height: MediaQuery.of(context).size.height/2,
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

                          child:  Text('Oops!\nMore then 1 face found\nTry Again..',style: GoogleFonts.gruppo(fontSize: 28,color: Colors.white,fontWeight: FontWeight.bold)),
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



void dialogAlertsEnrollmentnofacefound(BuildContext context) {

  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {

      return AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          // title: new Text("Alert Dialog title"),
          content:  Container(
            height: MediaQuery.of(context).size.height/2,
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

                          child:  Text('Oops!\nNo Face found in the image\nTry Again..',style: GoogleFonts.gruppo(fontSize: 28,color: Colors.white,fontWeight: FontWeight.bold)),
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

void dialogAlertsforpassport(BuildContext context) {

  showDialog(
    barrierDismissible: false,
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

                          child:  Text('Oops!\nCannot read the image.Please try again',style: GoogleFonts.gruppo(fontSize: 28,color: Colors.white,fontWeight: FontWeight.bold)),
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



void dialogAlertslforlogin(BuildContext context) {

  showDialog(
    barrierDismissible: false,
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

                          child:  Text('Oops!\nInvalid Username or Passowrd.\nPlease try again',style: GoogleFonts.gruppo(fontSize: 28,color: Colors.white,fontWeight: FontWeight.bold)),
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






void dialogAlertslforloginempty(BuildContext context) {

  showDialog(
    barrierDismissible: false,
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

                          child:  Text('Oops!\nFields are mandatory to fill.\nPlease try again',style: GoogleFonts.gruppo(fontSize: 28,color: Colors.white,fontWeight: FontWeight.bold)),
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



void dialogAlertslforTraining(BuildContext context) {

  showDialog(
    barrierDismissible: false,
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

                          child:  Text('Wait!\nYour Enrollment is in process.\nPlease wait for moments',style: GoogleFonts.gruppo(fontSize: 28,color: Colors.white,fontWeight: FontWeight.bold)),
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



void dialogAlertslforEnrollmentImage(BuildContext context) {

  showDialog(
    barrierDismissible: false,
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

                          child:  Text('Ooops!\nFor Enrollment process Image is important.\nPlease try again with image',style: GoogleFonts.gruppo(fontSize: 28,color: Colors.white,fontWeight: FontWeight.bold)),
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




void dialogAlertslforEnrollmentempty(BuildContext context) {

  showDialog(
    barrierDismissible: false,
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

                          child:  Text('Oops!\nName or ID is important.\nPlease try again',style: GoogleFonts.gruppo(fontSize: 28,color: Colors.white,fontWeight: FontWeight.bold)),
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




void dialogAlertslforEnrollmentSuccess(BuildContext context) {

  showDialog(
    barrierDismissible: false,
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

                          child:  Text('Congrates!\nYour enrollment is done successfully.',style: GoogleFonts.gruppo(fontSize: 28,color: Colors.white,fontWeight: FontWeight.bold)),
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

void dialogAlertForIdcard(BuildContext context){


  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {


      Widget cancelButton =  GestureDetector(
        onTap: () {
          print('cancel clicked');
          Navigator.of(context, rootNavigator: true).pop();
         /* setState(() {
            print('OOPS clicked');

          });*/

        },
        child:Container(
          height: MediaQuery.of(context).size.height/12,
          width: 100,
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
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child:Center(
              child:  Text("Cancel",style: GoogleFonts.gruppo(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold)),
            )
          )
        ),
      );

      Widget proceedButton =  GestureDetector(
        onTap: () {
          print('continue clicked');

          Navigator.of(context, rootNavigator: true).pop();
          movetocameraScanner(context);

          /* setState(() {
            print('OOPS clicked');

          });*/

        },
        child:Container(
          height: MediaQuery.of(context).size.height/12,
          width: 100,

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
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Center(
              child: Text("Continue",style: GoogleFonts.gruppo(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold)),
            )
          )
        ),
      );

      return AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          // title: new Text("Alert Dialog title"),
          content:  Container(
            height: MediaQuery.of(context).size.height/2,
            width: MediaQuery.of(context).size.width,
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

                          child:  Text('Do you want to generate I\'D card for this enrollment?',style: GoogleFonts.gruppo(fontSize: 28,color: Colors.white,fontWeight: FontWeight.bold)),
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                                child:   Padding(
                                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  child: cancelButton,),



                            ),
                            Expanded(
                              flex: 1,
                                child:Padding(
                                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  child: proceedButton,

                                ) )

                          ],
                        )
                      ],
                    )
                )
            ),
          ),

      );
    },
  );
}





movetocameraScanner(BuildContext context){
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => idCardScannerCamera()));

}