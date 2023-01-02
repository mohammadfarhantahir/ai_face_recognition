
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:ai_face/const/globals.dart' as globals;

import '../model/adminLoginModel.dart';



class Apiofcheckfolder {

  Future<List<AdminModel>?> adminLoginModel() async {
    try {
      // fetchagpid();
      var url = Uri.parse('http://'+globals.readIPURL!+'/face-recognition-webservice-master/adminlogin.php');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var value = response.body;
        String rep1 = value.toString().replaceAll('{', '');
        String rep2 = rep1.replaceAll('}', '');

        final split = rep2.toString().split(':');
        final Map<int, String> values = {
          for (int i = 0; i < split.length; i++)
            i: split[i]
        };
        // {0: grubs, 1:  sheep}

        final value1 = values[1].toString().replaceAll('}', '').replaceAll(']', '').replaceAll('"', '');
        globals.adminusername = value1.toString();

        print('---Admin Login result'+value1.toString());

        // globals.valueofstopstatus = repl6;
        //Toast.show(_recordmodel.toString(), context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);



      }
    } catch (e) {
      log(e.toString());
    }
  }

}