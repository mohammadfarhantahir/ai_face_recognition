import 'package:ai_face/const/globals.dart' as globals;
class Constants {

  static final String fetchFaces = 'http://'+globals.readIPURL!+'/face-recognition-webservice-master/facefoundresult.php?verification_by='+globals.username!;
  static final String userDetails = 'http://'+globals.readIPURL!+'/face-recognition-webservice-master/userdetails.php';





}