

import 'dart:async';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'dart:convert';
import 'dart:developer';


import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:path/path.dart';

import 'package:camera/camera.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:ai_face/const/globals.dart' as globals;

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';


import '../main.dart';


late String pathofimg ='';
bool facestatusknownUnknow= false;
File? localFile;
late String filepath1='';
late String resdata='';
late String imgpatfhforalert;
late String nameofface='';
late String _rere='';
int totalresult =0;
bool camPrevstatus = true;
bool statusofLive=true;


late String imageofface = '';
late File file1;
late  String finalPath;
PickedFile? _imageFile1;
File? _imageFile;
bool ss =false;
late final CameraController? cameraController;

late String scannedText ='';
bool textScanning = false;
class AnotherLiveCaptureFront extends StatefulWidget{

  State<AnotherLiveCaptureFront> createState()=> AnotherLiveCaptureFrontState();
}
class AnotherLiveCaptureFrontState extends State<AnotherLiveCaptureFront>{
  CameraController? controller;
  FlutterTts ftts = FlutterTts();
  Timer? timer1;
  var currentTime;
  Random random = new Random();
  String holdRanvalue='';
  late Stopwatch stopwatch;

  // Initial values
  bool _isCameraInitialized = false;
  bool _isCameraPermissionGranted = false;
  double _minAvailableExposureOffset = 0.0;
  double _maxAvailableExposureOffset = 0.0;
  double _minAvailableZoom = 1.0;
  double _maxAvailableZoom = 1.0;


  // Current values
  double _currentZoomLevel = 1.0;


  List<File> allFileList = [];

  final resolutionPresets = ResolutionPreset.values;

  ResolutionPreset currentResolutionPreset = ResolutionPreset.high;

  getPermissionStatus() async {
    await Permission.camera.request();
    var status = await Permission.camera.status;

    if (status.isGranted) {
      //log('Camera Permission: GRANTED');
      setState(() {
        _isCameraPermissionGranted = true;
      });
      // Set and initialize the new camera
      onNewCameraSelected(cameras[1]);

      refreshAlreadyCapturedImages();
    } else {
      // log('Camera Permission: DENIED');
    }
  }

  refreshAlreadyCapturedImages() async {
    final directory = await getApplicationDocumentsDirectory();
    List<FileSystemEntity> fileList = await directory.list().toList();
    allFileList.clear();
    List<Map<int, dynamic>> fileNames = [];

    fileList.forEach((file) {
      if (file.path.contains('.jpg') || file.path.contains('.mp4')) {
        allFileList.add(File(file.path));

        String name = file.path.split('/').last.split('.').first;
        fileNames.add({0: int.parse(name), 1: file.path.split('/').last});

      }
    });

    if (fileNames.isNotEmpty) {
      final recentFile =
      fileNames.reduce((curr, next) => curr[0] > next[0] ? curr : next);


      setState(() {});
    }
  }






  Future<XFile?> takePicture() async {
    final CameraController? cameraController = controller;


    if (cameraController!.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      XFile file = await cameraController.takePicture();
      //  pathofimg = file.path;
      file1 = new File(file.path);
      File tmpFile = File(file.path);
      File rotatedImage =
      await FlutterExifRotation.rotateAndSaveImage(path: file1.path);
      print('rotatwed image --->'+rotatedImage.path);


      finalPath = rotatedImage.path;


      print(tmpFile.path);



      //  insertVerificationRecord(context,holdRanvalue,currentTime.toString(),newtodaysdate);
      uploadImage(finalPath, uploadUrl);










      return file;
    } on CameraException catch (e) {
      print('Error occured while taking picture: $e');
      return null;
    }
  }


  late final String uploadUrl = 'http://'+globals.readIPURL!+':5000/api/recognize';
  Future<String?> uploadImage(filepath, url) async {

    // showAlertDialogserverresponsewait(context);
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('image', filepath));
    var res = await request.send();

    var responseBytes = await res.stream.toBytes();
    var responseString = utf8.decode(responseBytes);
    resdata = responseString.toString();
    _rere = resdata;
    print(resdata.toString());
    Map<String, dynamic> data = jsonDecode(_rere);


    String s = data["Name"].toString().replaceAll("[", "").replaceAll(']', '');
    if(s.isEmpty){
      print('value is empty');
      setState(() {
        nameofface = "No Face Found";






      });

    }
    else{
      final split = s.split(',');



      final Map<int, String> values = {
        for (int i = 0; i < split.length; i++)
          i: split[i]


      };


      final vaa1 = values[0];
      print('----->splitedd value'+vaa1.toString());
      totalresult = split.length;
      print('total faces are -->'+totalresult.toString());

      setState(() async {
        nameofface = s;
        //your custom configuration
        await ftts.setLanguage("en-US");
        await ftts.setSpeechRate(0.7); //speed of speech
        await ftts.setVolume(1.0); //volume of speech
        await ftts.setPitch(1); //pitc of sound

        //play text to sp
        var result = await ftts.speak('Person identified as '+nameofface);
        if(result == 1){
          print('Speaking');
          //speaking
        }else{
          //not speaking
          print('Not Speaking');
        }
      });
      globals.facedetailnameid = nameofface;
      globals.verifiedName = vaa1.toString();
      if(nameofface=='unknown'){
        setState(() {
          nameofface = "Unknown";




        });
      }
      else if(nameofface=='[]'){
        print('no face found');

        setState(() {
          nameofface = "No Face Detected";


        });


      }
      else{

        facestatusknownUnknow = true;
      }

      print("--->"+_rere);


      setState(() {

        var now = new DateTime.now();
        final updatedCurrentTime1 = DateFormat.jm().format(now);


        print('updated time is --->'+holdRanvalue+' '+updatedCurrentTime1+nameofface);





        print(responseString);
      });


    }












    return res.reasonPhrase;
  }



  void resetCameraValues() async {
    _currentZoomLevel = 1.0;

  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    final previousCameraController = controller;

    final CameraController cameraController = CameraController(
      cameraDescription,
      currentResolutionPreset,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    await previousCameraController?.dispose();



    resetCameraValues();

    if (mounted) {
      setState(() {

        controller = cameraController;
      });
    }

    // Update UI if controller updated
    cameraController.addListener(() {
      if (mounted) setState(() {


      });
    });

    try {
      await cameraController.initialize();
      await Future.wait([
        cameraController
            .getMinExposureOffset()
            .then((value) => _minAvailableExposureOffset = value),
        cameraController
            .getMaxExposureOffset()
            .then((value) => _maxAvailableExposureOffset = value),
        cameraController
            .getMaxZoomLevel()
            .then((value) => _maxAvailableZoom = value),
        cameraController
            .getMinZoomLevel()
            .then((value) => _minAvailableZoom = value),


      ]);


    } on CameraException catch (e) {
      print('Error initializing camera: $e');
    }

    if (mounted) {
      setState(()  {
        _isCameraInitialized = controller!.value.isInitialized;
        controller!.lockCaptureOrientation(DeviceOrientation.portraitUp);
      });
    }
  }



  void onViewFinderTap(TapDownDetails details, BoxConstraints constraints) {
    if (controller == null) {
      return;
    }

    final offset = Offset(
      details.localPosition.dx / constraints.maxWidth,
      details.localPosition.dy / constraints.maxHeight,
    );
    controller!.setExposurePoint(offset);
    controller!.setFocusPoint(offset);
  }

  @override
  void initState() {
    // Hide the status bar in Android
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    getPermissionStatus();


    super.initState();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    cameraController = controller;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController!.value.isInitialized) {

      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController!.dispose();
    } else if (state == AppLifecycleState.resumed) {
      onNewCameraSelected(cameraController!.description);
    }
  }

  @override
  void dispose() {
    timer1?.cancel();
    controller?.dispose();

    super.dispose();
  }

  int count =0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return

      SafeArea(
        // minimum: const EdgeInsets.only(bottom: 15.00),

        child:  Scaffold(
          appBar: AppBar(

            title: AutoSizeText('Live Camera Screen',style: GoogleFonts.gruppo(fontSize: 28,color: Colors.white,fontWeight: FontWeight.bold)),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[Color(0xff000000), Color(0xff000000)]),

              ),
            ),
          ),
          backgroundColor: Colors.black,
          body: _isCameraPermissionGranted
              ? _isCameraInitialized
              ? Container(
              decoration: BoxDecoration(
                  color: Color(0xFF000000),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    const BoxShadow(
                      color: Color(0xFFffffff),
                      offset: Offset(2, 2),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                    const BoxShadow(
                      color: Color(0xFFffffff),
                      offset: Offset(-2, -2),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ]
              ),

              margin: EdgeInsets.all(10) ,
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child:   Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 1 / controller!.value.aspectRatio,
                      child: Stack(
                        children: [

                          CameraPreview(
                            controller!,
                            child: LayoutBuilder(builder:
                                (BuildContext context,
                                BoxConstraints constraints) {
                              return GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTapDown: (details) =>
                                    onViewFinderTap(details, constraints),
                              );
                            }),
                          ),


                          Positioned(
                              bottom: MediaQuery.of(context).size.height/1.8,
                              left: 50,
                              right: 50,

                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Color(0xFF000000),
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        const BoxShadow(
                                          color: Color(0xFFffffff),
                                          offset: Offset(2, 2),
                                          blurRadius: 10,
                                          spreadRadius: 1,
                                        ),
                                        const BoxShadow(
                                          color: Color(0xFFffffff),
                                          offset: Offset(-2, -2),
                                          blurRadius: 10,
                                          spreadRadius: 1,
                                        ),
                                      ]
                                  ),
                                  child:  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                    child: AutoSizeText("Person identified as \n"+nameofface,style: GoogleFonts.gruppo(fontSize: 28,color: Colors.white,fontWeight: FontWeight.bold)),
                                  )

                              )


                          ),

                          Positioned(
                              bottom: 80,
                              left: 50,
                              right: 50,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(10, 10, 20, 10),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF000000),
                                                  borderRadius: BorderRadius.circular(20),
                                                  boxShadow: [
                                                    const BoxShadow(
                                                      color: Color(0xFFffffff),
                                                      offset: Offset(2, 2),
                                                      blurRadius: 10,
                                                      spreadRadius: 1,
                                                    ),
                                                    const BoxShadow(
                                                      color: Color(0xFFffffff),
                                                      offset: Offset(-2, -2),
                                                      blurRadius: 10,
                                                      spreadRadius: 1,
                                                    ),
                                                  ]
                                              ),

                                              child: Slider(
                                                value: _currentZoomLevel,
                                                min: _minAvailableZoom,
                                                max: _maxAvailableZoom,
                                                activeColor: Colors.white,
                                                inactiveColor: Colors.white30,
                                                onChanged: (value) async {
                                                  setState(() {
                                                    _currentZoomLevel = value;
                                                  });
                                                  await controller!
                                                      .setZoomLevel(value);
                                                },
                                              ),
                                            ),
                                          )
                                      ),

                                    ],
                                  ),


                                ],
                              )


                          ),
                          Positioned(
                              bottom: 0,
                              left: 50,
                              right: 50,
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Color(0xFF000000),
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        const BoxShadow(
                                          color: Color(0xFFffffff),
                                          offset: Offset(2, 2),
                                          blurRadius: 10,
                                          spreadRadius: 1,
                                        ),
                                        const BoxShadow(
                                          color: Color(0xFFffffff),
                                          offset: Offset(-2, -2),
                                          blurRadius: 10,
                                          spreadRadius: 1,
                                        ),
                                      ]
                                  ),
                                  child:  Padding(
                                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                      child: InkWell(
                                        onTap: (){

                                          setState(() {

                                            statusofLive=false;
                                            const oneSec = Duration(milliseconds:5);
                                            timer1 =Timer.periodic(oneSec, (Timer t) =>

                                                takePicture().then((value) =>

                                                    controller!.resumePreview()

                                                )

                                            );

                                          });



                                        },
                                        child: statusofLive?AutoSizeText("Start Live Recognizing",style: GoogleFonts.gruppo(fontSize: 28,color: Colors.white,fontWeight: FontWeight.bold)):
                                        InkWell(
                                            onTap: (){

                                              setState(() {

                                                statusofLive=true;
                                                timer1?.cancel();


                                              });



                                            },
                                            child:
                                            AutoSizeText("Stop Live Recognizing",style: GoogleFonts.gruppo(fontSize: 28,color: Colors.white,fontWeight: FontWeight.bold))
                                        )
                                        ,

                                      )




                                  )

                              ))




                        ],
                      ),
                    ),

                  ],
                ),
              )

          )
              : Center(
            child: Text(
              'NiGELLA SOFTWARES CAMERA LOADING',
              style: TextStyle(color: Colors.white),
            ),
          )
              : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(),
              Text(
                'Permission denied',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  getPermissionStatus();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Give permission',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  }

}

