import 'package:ai_face/screens/main1.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

List<CameraDescription> cameras = [];
Future<void> main() async {

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
      home: loginScreen(),
    );
  }
}