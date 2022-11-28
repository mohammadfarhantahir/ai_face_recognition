import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:toast/toast.dart';

import 'mlkit_face_detector_view.dart';
import 'mllkit_camera_view.dart';





class FaceDetectorView extends StatefulWidget {
  @override
  _FaceDetectorViewState createState() => _FaceDetectorViewState();
}

class _FaceDetectorViewState extends State<FaceDetectorView> {
  final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableContours: true,
      enableClassification: true,
    ),
  );
  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  String? _text;

  @override
  void dispose() {
    _canProcess = false;
    _faceDetector.close();
    super.dispose();
  }
  late int count=0;
  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
        onWillPop: () async {

          count++;
          if(count==1){



           // Toast.show('Press again to go back!', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);


            // showaip(context);


          }
          if(count==2){
            gobacktomain(context);
            // Toast.show('Back button press  2nd time', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
            /*  if (Platform.isAndroid) {
              SystemNavigator.pop();
            } else if (Platform.isIOS) {
              exit(0);
            }*/
          }
          else{
            // Toast.show('Back button press'+count.toString(), context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
          }
          // Do something here
          print("After clicking the Android Back Button");

          return false;
        },
        child:
        CameraView(
          title: 'Enroll Face Camera',
          customPaint: _customPaint,
          text: _text,
          onImage: (inputImage) {
            processImage(inputImage);
          },
          initialDirection: CameraLensDirection.front,
        )
    );
  }

  Future<void> processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    setState(() {
      _text = '';
    });
    final faces = await _faceDetector.processImage(inputImage);
    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null) {
      final painter = FaceDetectorPainter(
          faces,
          inputImage.inputImageData!.size,
          inputImage.inputImageData!.imageRotation);
      _customPaint = CustomPaint(painter: painter);
    } else {
      String text = 'Faces found: ${faces.length}\n\n';
      for (final face in faces) {
        text += 'face: ${face.boundingBox}\n\n';
      }
      _text = text;
      // TODO: set _customPaint to draw boundingRect on top of image
      _customPaint = null;
    }
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}

void gobacktomain(BuildContext context){



//  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => FirstScreen()));

}