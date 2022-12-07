


import 'package:http/http.dart' as http;
import 'dart:developer';
import 'package:ai_face/const/globals.dart'  as globals;

import '../model/stopModel.dart';
import 'package:flutter/material.dart';
class ApiofTrainmodel {

  Future<List<StopModel>?> gettrainapiresult() async {
    try {
      // fetchagpid();
      var url = Uri.parse('http://'+globals.readIPURL!+':6002/train');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var value = response.body;
        String rep1 = value.toString().replaceAll('{', '');
        String repl2 = rep1.replaceAll('}', '');
        String rep3 = repl2.replaceAll('"', '');
        final split = value.toString().split(':');
        final Map<int, String> values = {
          for (int i = 0; i < split.length; i++)
            i: split[i]
        };
        // {0: grubs, 1:  sheep}

        final value1 = values[1].toString().replaceAll('}', '');
        String repl6 = value1.replaceAll(new RegExp(r'(?:[\t ]*(?:\r?\n|\r))+'), '');
        int count=0;

        // showAlertWait(context);
        if(repl6!=' 0'){
          print(count++);

        }
        print('-->'+repl6.toString()+'<------');

        print(globals.valueoftrainstatus);

        globals.valueoftrainstatus = repl6;
        //Toast.show(_recordmodel.toString(), context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);



      }
    } catch (e) {
      log(e.toString());
    }
  }

}