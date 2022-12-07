

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:ai_face/const/globals.dart' as globals;



Future insertVerificationRecord(BuildContext context,uId,time,date) async{


  // API URL
  var url = 'http://face.ladang.tech/face-recognition-webservice-master/insertverificationrecord.php';


    // Store all data with Param Name.
    var data = {'uId':uId,'verification_by': globals.username, 'verification_start_time': time, 'verification_end_time' : '', 'verification_lat' :'2442.00'
      , 'verification_long' : '80909.0', 'verification_date' : date, 'verification_result' :''};

    // Starting Web Call with data.

    var response = await http.post(Uri.parse(url), body: json.encode(data));

    // Getting Server response into variable.
    var message = jsonDecode(response.body);
    print(message.toString());






}




