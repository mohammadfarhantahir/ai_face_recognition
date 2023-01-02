

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:ai_face/const/globals.dart' as globals;



Future updateVerificationRecord(BuildContext context,uId,time,verificationResult) async{


  // API URL
  var url = 'http://'+globals.readIPURL!+'/face-recognition-webservice-master/verificationUpdate.php';


  // Store all data with Param Name.
  var data = {'uId':uId,'verification_by':globals.username,'verification_end_time': time,  'verification_result' : verificationResult};

  // Starting Web Call with data.

  var response = await http.post(Uri.parse(url), body: data);

  // Getting Server response into variable.
  var message = jsonDecode(response.body);
  print(message.toString());






}




