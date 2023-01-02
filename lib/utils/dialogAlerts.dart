

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ai_face/const/globals.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';

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

                     child:  AutoSizeText('Oops!\nFace not found in this image',style: GoogleFonts.gruppo(fontSize: 28,color: Colors.white,fontWeight: FontWeight.bold)),
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

                          child:  AutoSizeText('Oops!\nThis person is already regisitered in our system\nplease contact ADMIN for more information',style: GoogleFonts.gruppo(fontSize: 28,color: Colors.white,fontWeight: FontWeight.bold)),
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

                          child:  AutoSizeText('Oops!\nName already found in the system\nTry Other name',style: GoogleFonts.gruppo(fontSize: 28,color: Colors.white,fontWeight: FontWeight.bold)),
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

                          child:  AutoSizeText('Oops!\nMore then 1 face found\nTry Again..',style: GoogleFonts.gruppo(fontSize: 28,color: Colors.white,fontWeight: FontWeight.bold)),
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

                          child:  AutoSizeText('Oops!\nNo Face found in the image\nTry Again..',style: GoogleFonts.gruppo(fontSize: 28,color: Colors.white,fontWeight: FontWeight.bold)),
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

                          child:  AutoSizeText('Oops!\nCannot read the image.Please try again',style: GoogleFonts.gruppo(fontSize: 28,color: Colors.white,fontWeight: FontWeight.bold)),
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
            height: MediaQuery.of(context).size.height/1.5,
            child: Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child:Container(

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

                          child:  Text('Oops!\nInvalid Username or Passowrd.\nPlease try again',style: GoogleFonts.gruppo(fontSize:28,color: Colors.white,fontWeight: FontWeight.bold)),
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



void dialogAlertslforAdminlogin(BuildContext context) {

  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {

      return AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          // title: new Text("Alert Dialog title"),
          content:  Container(
            height: MediaQuery.of(context).size.height/1.5,
            child: Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child:Container(

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

                          child:  Text('Oops!\nYou\'re not Admin.\nPlease try again',style: GoogleFonts.gruppo(fontSize:28,color: Colors.white,fontWeight: FontWeight.bold)),
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
                    child:Column(
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

                          child:FittedBox(
                            child:   Text('Oops!\nFields are mandatory to fill.\nPlease try again',style: GoogleFonts.gruppo(fontSize: 28,color: Colors.white,fontWeight: FontWeight.bold)),
                          )



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


void dialogAlertslforiperror(BuildContext context) {

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

                          child: Text('Ooops!\nCannot connected to the provided I.P.\nPlease try again with another i.p',style: GoogleFonts.gruppo(color: Colors.white,fontWeight: FontWeight.bold)),




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




void dialogAlertslforPinging(BuildContext context) {

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

                          child:  Text('Ooops!\nServer not reachable\nTry Again',style: GoogleFonts.gruppo(fontSize: 28,color: Colors.white,fontWeight: FontWeight.bold)),
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

TextEditingController urlControlleralogin = TextEditingController();

void dialogAlertslforloginsetup(BuildContext context) {

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
                    height: MediaQuery.of(context).size.height/2,
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

                          child:  Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 100,
                                width: MediaQuery.of(context).size.width,
                                child: AutoSizeText('Please enter your offline/online server url',style: GoogleFonts.gruppo(fontSize:28,color: Colors.white,fontWeight: FontWeight.bold)
                                ),

                                /*ConstrainedBox(
                                  constraints: BoxConstraints(
                                    minWidth: 300.0,
                                    maxWidth: 300.0,
                                    minHeight: 30.0,
                                    maxHeight: 100.0,
                                  ),
                                  child:  Text('Please enter your offline/online server url',style: GoogleFonts.gruppo(fontSize:28,color: Colors.white,fontWeight: FontWeight.bold)
                                ),

                               ),*/
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
                                        style: GoogleFonts.didactGothic(fontSize: 18,color: Colors.white),
                                        keyboardType: TextInputType.numberWithOptions(),
                                        controller: urlControlleralogin,
                                        decoration: InputDecoration(



                                          floatingLabelBehavior: FloatingLabelBehavior.never,
                                          //  hintText: 'Email',
                                          // hintStyle: GoogleFonts.didactGothic(fontSize: 18,color: Colors.black),

                                          border: InputBorder.none,
                                          labelText: 'Enter I.P',
                                          labelStyle: GoogleFonts.didactGothic(fontSize: 18,color: Colors.black),
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
                                        child:   GestureDetector(
                                          onTap: () {

                                            print('cancel clicked');

                                            Navigator.pop(context);

                                          },
                                          child:  AutoSizeText('Cancel',style: GoogleFonts.gruppo(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold)),
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
                                        child: GestureDetector(
                                            onTap: () {
                                              globals.readIPURL = urlControlleralogin.text.toString();
                                              print('continued clicked'+globals.readIPURL!);
                                              addStringToSF();

                                              Navigator.pop(context);

                                            },
                                            child:  AutoSizeText('Continue',style: GoogleFonts.gruppo(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold)),
                                        ),
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
                          )
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

addStringToSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('ipURL', urlControlleralogin.text);


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