

import 'package:http/http.dart' as http;
import 'package:ai_face/const/globals.dart' as globals;


Future insertTrainingModelDetails() async{






  // API URL
  var url = 'http://'+globals.readIPURL!+'/face-recognition-webservice-master/train/train_model_insertation.php';

  // Store all data with Param Name.
  final split = globals.filepaths.split('/');
  final Map<int, String> values = {
    for (int i = 0; i < split.length; i++)
      i: split[i]
  };

  final imagevalue = values[6];

  var data = {
    'folder_name':globals.storefoldername,'image_name':imagevalue.toString(),'enrolled_by':globals.username,'folder_creation_date':globals.newtodaysdate,'folder_creation_time':globals.currenttime,'folder_have_model':'False',
  };


  // Starting Web Call with data.
  var response = await http.post(Uri.parse(url), body: data);

  String message = response.body;

  // Getting Server response into variable.
  // var message = jsonDecode(response.body);

  print('mysql insertation response'+message);


  // If Web call Success than Hide the CircularProgressIndicator.




}

