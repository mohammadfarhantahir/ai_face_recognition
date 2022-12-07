import 'package:ai_face/screens/enrollment.dart';
import 'package:ai_face/screens/face_found_History.dart';
import 'package:ai_face/screens/homeScreen.dart';
import 'package:ai_face/screens/howtouse.dart';
import 'package:ai_face/screens/loginScreen.dart';
import 'package:ai_face/screens/main1.dart';
import 'package:ai_face/screens/mlKitfaceDetectorView.dart';
import 'package:ai_face/screens/verifyBackcamera.dart';
import 'package:ai_face/screens/verifyFrontcamera.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<CameraDescription> cameras = [];
var email;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs =await SharedPreferences.getInstance();
  email=prefs.getString("username");
  print(email.toString());

  try {
    WidgetsFlutterBinding.ensureInitialized();

    cameras = await availableCameras();

  } on CameraException catch (e) {
    print('Error in fetching the cameras: $e');
  }
  runApp( MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      home: email==null? loginScreen():homeScreen(),
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the HomeScreen widget.
        '/howtouse': (context) => howtouse(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/homescreen': (context) => homeScreen(),
        '/loginscreen': (context) => loginScreenMain(),
        '/facFoundHistory': (context) => facFoundHistory(),
        '/backCamera': (context) => backCamera(),
        '/verifyFrontCamera' : (context) => verifyFrontCamera(),
        '/enrollment' : (context) => enrollment(),
        '/FaceDetectorView' : (context) => FaceDetectorView(),

      },
    );
  }
}