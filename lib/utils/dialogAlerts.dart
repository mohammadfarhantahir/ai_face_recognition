

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


void dialogAlerts(BuildContext context) {

  showDialog(
    context: context,
    builder: (BuildContext context) {

      return AlertDialog(
       // title: new Text("Alert Dialog title"),
        content: Container(
          height: MediaQuery.of(context).size.height/3,
          child: Stack(
            children: [
              Positioned(
                top:450,
                  child: Icon(Icons.cancel)
              )
            ],
          ),
        )
      );
    },
  );
}