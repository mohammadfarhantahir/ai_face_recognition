import 'dart:io';
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:camera/camera.dart' as camera1;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'package:ai_face/const/globals.dart' as globals;
import 'package:toast/toast.dart';
import '../const/globals.dart';
import '../main.dart';
import 'enrollment.dart';


late File file1;
late  String finalPath;
CameraController? _controller;
enum ScreenMode { liveFeed, gallery }

class CameraView extends StatefulWidget {
  CameraView(
      {Key? key,
        required this.title,
        required this.customPaint,
        this.text,
        required this.onImage,
        this.onScreenModeChanged,
        this.initialDirection = CameraLensDirection.back})
      : super(key: key);

  final String title;
  final CustomPaint? customPaint;
  final String? text;
  final Function(InputImage inputImage) onImage;
  final Function(ScreenMode mode)? onScreenModeChanged;
  final CameraLensDirection initialDirection;

  @override
  _CameraViewState createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {

  ScreenMode _mode = ScreenMode.liveFeed;

   camera1.CameraController? cameraController1;
  File? _image;

  String? _path;
  ImagePicker? _imagePicker;
  int _cameraIndex = 0;
  double zoomLevel = 0.0, minZoomLevel = 0.0, maxZoomLevel = 0.0;
  final bool _allowPicker = true;
  bool _changingCameraLens = false;
  bool _isCameraInitialized = false;
  bool _isCameraPermissionGranted = false;
  bool _isRearCameraSelected = true;
  bool _isVideoCameraSelected = false;
  bool _isRecordingInProgress = false;
  double _minAvailableExposureOffset = 0.0;
  double _maxAvailableExposureOffset = 0.0;
  double _minAvailableZoom = 1.0;
  double _maxAvailableZoom = 1.0;
  FlashMode? _currentFlashMode;
  ResolutionPreset currentResolutionPreset = ResolutionPreset.high;
  @override
  void initState() {
    super.initState();


    _imagePicker = ImagePicker();

    if (cameras.any(
          (element) =>
      element.lensDirection == widget.initialDirection &&
          element.sensorOrientation == 90,
    )) {
      _cameraIndex = cameras.indexOf(
        cameras.firstWhere((element) =>
        element.lensDirection == widget.initialDirection &&
            element.sensorOrientation == 90),
      );
    } else {
      _cameraIndex = cameras.indexOf(
        cameras.firstWhere(
              (element) => element.lensDirection == widget.initialDirection,
        ),
      );
    }

    _startLiveFeed();
  }

  @override
  void dispose() {
    // _stopLiveFeed();
    super.dispose();
  }


  Future<XFile?> takePicture(BuildContext context) async {

    final camera1.CameraController? cameraController12 = _controller ;
    try {
      XFile file = await cameraController12!.takePicture();
      //  pathofimg = file.path;
      file1 = new File(file.path);
      File tmpFile = File(file.path);
      File rotatedImage =
      await FlutterExifRotation.rotateAndSaveImage(path: file1.path);
      print('rotatwed image --->'+rotatedImage.path);

      // 5. Get the path to the apps directory so we can save the file to it.

      // 6. Save the file by copying it to the new location on the device.
      //  tmpFile = await file1.copy(file1.path);
      finalPath = rotatedImage.path;

      globals.finalpathfromfacedetector = rotatedImage.path;
      var bytes = await new File(finalPath).readAsBytes();
      globals.uint8Listglobal =  bytes.buffer.asUint8List();
      final tempDir = await getTemporaryDirectory();
      var rnd = new Random();
      var next = rnd.nextDouble() * 1000000;
      while (next < 100000) {
        next *= 10;
      }
      print(next.toInt());
      String valueofrandom= next.toInt().toString();
      File file12 = await File('${tempDir.path}/'+valueofrandom+'.png').create();
      file12.writeAsBytesSync(globals.uint8Listglobal!);
      print('uint8List value------>'+file12.path+'\n'+'======>'+valueofrandom);
      globals.filepaths = file12.path;
      globals.mlcamerabool = true;
      print(globals.uint8Listglobal.toString());
      print(tmpFile.path);
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => enrollment()));








      return file;
    } on CameraException catch (e) {
      print('Error occured while taking picture: $e');
      return null;
    }


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => gobacktomain(context),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[Color(0xff6B5EFE), Color(0xff8A81FF)]),

          ),
        ),
      ),
      body: _body(),
      floatingActionButton: _floatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

    );
  }

  Widget? _floatingActionButton() {
    if (_mode == ScreenMode.gallery) return null;
    if (cameras.length == 1) return null;
    return SizedBox(
      height: 70.0,
      width: 70.0,
      child: FloatingActionButton(
        backgroundColor: Color(0xff6B5EFE),
        child: Icon(
          color: Color(0xffffffff),
          Platform.isIOS
              ? Icons.flip_camera_ios_outlined
              : Icons.flip_camera_android_outlined,
          size: 40,
        ),
        onPressed: _switchLiveCamera,
      ),

    );
  }

  Widget _body() {
    Widget body;
    if (_mode == ScreenMode.liveFeed) {
      body = _liveFeedBody();
    } else {
      body = _galleryBody();
    }
    return body;
  }

  Widget _liveFeedBody() {
    if (_controller?.value.isInitialized == false) {
      return Container();
    }

    final size = MediaQuery.of(context).size;
    // calculate scale depending on screen and camera ratios
    // this is actually size.aspectRatio / (1 / camera.aspectRatio)
    // because camera preview size is received as landscape
    // but we're calculating for portrait orientation
    var scale = size.aspectRatio * _controller!.value.aspectRatio;

    // to prevent scaling down, invert the value
    if (scale < 1) scale = 1 / scale;

    return Container(
      color: Colors.black,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Transform.scale(
            scale: scale,
            child: Center(
              child: _changingCameraLens
                  ? Center(
                child: const Text('Changing camera lens'),
              )
                  : CameraPreview(_controller!),
            ),
          ),
          if (widget.customPaint != null) widget.customPaint!,
          Positioned(
            bottom: 100,
            left: 50,
            right: 50,
            child: Slider(
              activeColor: Color(0xff6B5EFE), // The color to use for the portion of the slider track that is active.
              inactiveColor: Color(0xff8A81FF), // The color for the inactive portion of the slider track.
              thumbColor: Color(0xff6B5EFE),
              value: zoomLevel,
              min: minZoomLevel,
              max: maxZoomLevel,
              onChanged: (newSliderValue) {
                setState(() {
                  zoomLevel = newSliderValue;
                  _controller!.setZoomLevel(zoomLevel);
                });
              },
              divisions: (maxZoomLevel - 1).toInt() < 1
                  ? null
                  : (maxZoomLevel - 1).toInt(),
            ),
          ),
          Positioned(
              bottom: 160,
              left: 10,
              right: 10,
              child:  Container(
                height: 70,
                width: 150,
                child:  globals.takingimagestatus?capturebutton(context):circularcustomprogress(context),
              )

          )

        ],
      ),
    );
  }
  Widget circularcustomprogress(BuildContext context){
    return Container(


        child:
        Material(
          elevation: 10.0,
          borderRadius: BorderRadius.circular(30.0),//12
          color: Colors.transparent,//Colors.cyan.withOpacity(0.5),
          child:MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            color: Colors.red.withOpacity(0.7),
            shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(30.0) ),
            splashColor: Colors.red,
            onPressed: () async {

              Toast.show('Cannot take Picture....', duration: Toast.lengthLong, gravity:  Toast.bottom);


              // _navigatetoenrollment(context);

            },
            child: Text('Capture Button will be automatically appeared on the screen once the camera detect HUMAN faces',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  //fontFamily: lang.font
                )),
          ),


        )
    );
  }

  Widget capturebutton(BuildContext context){
    return  Container(
      height: 50,
      width:  150,
      child: Material(
        elevation: 10.0,
        borderRadius: BorderRadius.circular(30.0),//12
        color: Colors.transparent,//Colors.cyan.withOpacity(0.5),
        child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          color: Colors.cyan.withOpacity(0.7),
          shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(30.0) ),
          splashColor: Colors.cyan,
          onPressed: () async {
            _controller!.stopImageStream();
            _stopLiveFeed();

            takePicture(context);



            // _navigatetoenrollment(context);

          },
          child: Text('Capture Image',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
                fontWeight: FontWeight.w400,
                //fontFamily: lang.font
              )),
        ),
      ),
    );



  }

  Widget _galleryBody() {
    return ListView(shrinkWrap: true, children: [
      _image != null
          ? SizedBox(
        height: 400,
        width: 400,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.file(_image!),
            if (widget.customPaint != null) widget.customPaint!,
          ],
        ),
      )
          : Icon(
        Icons.image,
        size: 200,
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: ElevatedButton(
          child: Text('From Gallery'),
          onPressed: () => _getImage(ImageSource.gallery),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: ElevatedButton(
          child: Text('Take a picture'),
          onPressed: () => _getImage(ImageSource.camera),
        ),
      ),
      if (_image != null)
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
              '${_path == null ? '' : 'Image path: $_path'}\n\n${widget.text ?? ''}'),
        ),
    ]);
  }

  Future _getImage(ImageSource source) async {
    setState(() {
      _image = null;
      _path = null;
    });
    final pickedFile = await _imagePicker?.pickImage(source: source);
    if (pickedFile != null) {
      _processPickedFile(pickedFile);
    }
    setState(() {});
  }

  void _switchScreenMode() {
    _image = null;
    if (_mode == ScreenMode.liveFeed) {
      _mode = ScreenMode.gallery;
      _stopLiveFeed();
    } else {
      _mode = ScreenMode.liveFeed;
      _startLiveFeed();
    }
    if (widget.onScreenModeChanged != null) {
      widget.onScreenModeChanged!(_mode);
    }
    setState(() {});
  }

  Future _startLiveFeed() async {
    final camera = cameras[_cameraIndex];
    _controller = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: false,
    );
    _controller?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      _controller?.getMinZoomLevel().then((value) {
        zoomLevel = value;
        minZoomLevel = value;
      });
      _controller?.getMaxZoomLevel().then((value) {
        maxZoomLevel = value;
      });
      _controller?.startImageStream(_processCameraImage);
      setState(() {




      });
    });
  }

  Future _stopLiveFeed() async {
    await _controller?.stopImageStream();
    await _controller?.dispose();
    _controller = null;
  }

  Future _switchLiveCamera() async {
    setState(() => _changingCameraLens = true);
   // _cameraIndex = (_cameraIndex + 1) % cameras.length;

    await _stopLiveFeed();
    await _startLiveFeed();
    setState(() => _changingCameraLens = false);
  }

  Future _processPickedFile(XFile? pickedFile) async {
    final path = pickedFile?.path;
    if (path == null) {
      return;
    }
    setState(() {
      _image = File(path);
    });
    _path = path;
    final inputImage = InputImage.fromFilePath(path);
    widget.onImage(inputImage);
  }

  Future _processCameraImage(CameraImage image) async {
    final WriteBuffer allBytes = WriteBuffer();
    for (final Plane plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();

    final Size imageSize =
    Size(image.width.toDouble(), image.height.toDouble());

    final camera = cameras[_cameraIndex];
    final imageRotation =
    InputImageRotationValue.fromRawValue(camera.sensorOrientation);
    if (imageRotation == null) return;

    final inputImageFormat =
    InputImageFormatValue.fromRawValue(image.format.raw);
    if (inputImageFormat == null) return;

    final planeData = image.planes.map(
          (Plane plane) {
        return InputImagePlaneMetadata(
          bytesPerRow: plane.bytesPerRow,
          height: plane.height,
          width: plane.width,
        );
      },
    ).toList();

    final inputImageData = InputImageData(
      size: imageSize,
      imageRotation: imageRotation,
      inputImageFormat: inputImageFormat,
      planeData: planeData,
    );

    final inputImage =
    InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);

    widget.onImage(inputImage);
  }
}
void gobacktomain(BuildContext context){
  _controller!.stopImageStream();
 // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => FirstScreen()));

}

void gobacktoenrollment(BuildContext context){

 // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Enrollmentwithlivness()));
}
