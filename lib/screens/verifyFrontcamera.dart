

import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:developer';

import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

import 'package:camera/camera.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:ai_face/const/globals.dart' as globals;

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:toast/toast.dart';

import '../api/insert_verification_record.dart';
import '../api/update_verification_record.dart';
import '../main.dart';
import '../utils/dialogAlerts.dart';

late String pathofimg ='';
bool facestatusknownUnknow= false;
File? localFile;
late String filepath1='';
late String resdata='';
late String imgpatfhforalert;
late String nameofface='';
late String _rere='';



late String imageofface = '';
late File file1;
late  String finalPath;
PickedFile? _imageFile1;
File? _imageFile;
bool ss =false;
late final CameraController? cameraController;

late String scannedText ='';
bool textScanning = false;
class verifyFrontCamera extends StatefulWidget{

  State<verifyFrontCamera> createState()=> _verifyfrontCameraState();
}
class _verifyfrontCameraState extends State<verifyFrontCamera>{
  CameraController? controller;
  var currentTime;
  Random random = new Random();
  String holdRanvalue='';


  // Initial values
  bool _isCameraInitialized = false;
  bool _isCameraPermissionGranted = false;
  bool _isRearCameraSelected = true;
  bool _isVideoCameraSelected = false;
  bool _isRecordingInProgress = false;
  double _minAvailableExposureOffset = 0.0;
  double _maxAvailableExposureOffset = 0.0;
  double _minAvailableZoom = 1.0;
  double _maxAvailableZoom = 1.0;


  // Current values
  double _currentZoomLevel = 1.0;
  double _currentExposureOffset = 0.0;
  FlashMode? _currentFlashMode;

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




  Future<XFile?> takePicture(BuildContext context) async {
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
      var now = new DateTime.now();
      currentTime = DateFormat.jm().format(now);
      var formatter = new DateFormat('MM');
      var formattertext = new DateFormat('MMM');
      var formatteryear = new DateFormat('yyyy');
      var formatterdat = new DateFormat('dd');
      String currentMOnth = formatter.format(now);
      String currentYEar =  formatteryear.format(now);
      String currentday = formatterdat.format(now);
      String currentdate = currentday;
      String todaysdate = currentdate+'/'+currentMOnth+'/'+currentYEar;
      String newtodaysdate = currentdate+'-'+currentMOnth+'-'+currentYEar;
      setState(() {
        int randomNumber = random.nextInt(1000); // from 0 upto 990 included
        holdRanvalue = randomNumber.toString();
      });
      print('current time is --->'+holdRanvalue+' '+currentTime.toString()+newtodaysdate);
      insertVerificationRecord(context,holdRanvalue,currentTime.toString(),newtodaysdate);
      uploadImage(finalPath, uploadUrl, context);










      return file;
    } on CameraException catch (e) {
      print('Error occured while taking picture: $e');
      return null;
    }
  }

  late final String uploadUrl = 'http://'+globals.readIPURL!+':5000/api/recognize';
  Future<String?> uploadImage(filepath, url,BuildContext context) async {

    // showAlertDialogserverresponsewait(context);
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('image', filepath));
    var res = await request.send();
    if(res.statusCode==500){
      print('no face found');

      setState(() {
        var now = new DateTime.now();
        final updatedCurrentTime = DateFormat.jm().format(now);
        var formatter = new DateFormat('MM');
        var formattertext = new DateFormat('MMM');
        var formatteryear = new DateFormat('yyyy');
        var formatterdat = new DateFormat('dd');
        String currentMOnth = formatter.format(now);
        String currentYEar =  formatteryear.format(now);
        String currentday = formatterdat.format(now);
        String currentdate = currentday;
        String todaysdate = currentdate+'/'+currentMOnth+'/'+currentYEar;
        String newtodaysdate = currentdate+'-'+currentMOnth+'-'+currentYEar;
        print('updated time is --->'+holdRanvalue+' '+updatedCurrentTime+'no face found');
        updateVerificationRecord(context,holdRanvalue,updatedCurrentTime,'no face found');
        globals.dialogloading=true;
        dialogAlerts(context);
      });

      // showAlertDialognofacedfound(context);

    }
    else{

      var responseBytes = await res.stream.toBytes();
      var responseString = utf8.decode(responseBytes);
      resdata = responseString.toString();
      _rere = resdata;
      print(resdata.toString());
      Map<String, dynamic> data = jsonDecode(_rere);
      var token = data["image"];
      var statusdata = data["image"];
      String s = data["name"].toString().replaceAll("[", "");
      nameofface =s.replaceAll("]", "");
      globals.verifiedName = nameofface;
      if(nameofface=='unknown'){

        facestatusknownUnknow = false;
      }
      else{

        facestatusknownUnknow = true;
      }
      String imgval = statusdata.toString().replaceAll(' ', '');
      String imgval1 = imgval.replaceAll("[", '');
      String imgval2= imgval1.replaceAll(']', '');
      imageofface = imgval2;
      print("``````````````"+token.toString());
      print("--->"+_rere);
      scannedText = imgval2;

      if(scannedText!=null){
        ss = true;
        // Navigator.of(context, rootNavigator: true).pop();


      }
      else{
        print('NULLLL');
      }
      setState(() {
        var now = new DateTime.now();
        final updatedCurrentTime1 = DateFormat.jm().format(now);


        print('updated time is --->'+holdRanvalue+' '+updatedCurrentTime1+nameofface);
        updateVerificationRecord(context,holdRanvalue,updatedCurrentTime1,nameofface);
        globals.dialogloading=true;
        _previewImageFrontAlert(context);
        print(responseString);
      });


    }








    return res.reasonPhrase;
  }

  _previewImageFrontAlert(BuildContext context) {

    // textfield for url
    // set up the buttons
    final decodestring = base64Decode('$imageofface'
        .split(',')
        .last);
    Uint8List encodeedimg = decodestring;


    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title:  Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {

                print('cross clicked');
                Navigator.pop(context);
              },
              child:
              Icon(Icons.cancel,color: Colors.white,size: 40,),
            )
          ],
        ),

        content: Container(
          height: MediaQuery.of(context).size.height/2,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Color(0xFFE000000),
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
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Container(
                  // height: 100,
                  child:  Align(
                    alignment: Alignment.center,
                    child: Container(

                      child: Text('Face Recognition Result',style: GoogleFonts.gruppo(fontSize: 28,color: Colors.white,fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),


              Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child:TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 0.0, end: 1),
                    duration: const Duration(seconds: 3),
                    builder: (context, value, _) => Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100.0),
                              child:   Image.file(
                                File(finalPath),
                                fit: BoxFit.cover,
                                height: 200,
                                width: 200,
                              ),
                            )
                        ),
                        // you can replace
                        Container(

                          height: 200,
                          width: 200,

                          child:  CircularProgressIndicator(

                            valueColor: facestatusknownUnknow?AlwaysStoppedAnimation<Color>(Colors.white):AlwaysStoppedAnimation<Color>(Colors.red),
                            strokeWidth: 5.7,
                            value: value,
                          ),
                        )
                      ],
                    ),
                  )
              ),



              Padding(
                  padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
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
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(5, 5, 20, 5),
                            child: Text('Name: $nameofface',style: GoogleFonts.gruppo(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold)),
                          )
                      ),
                      SizedBox(
                        width: 40,
                      ),


                    ],
                  )
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: facestatusknownUnknow?Text('Found',style: GoogleFonts.gruppo(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold)
                      ,):Text('Not Found',style: GoogleFonts.gruppo(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold)),
                  )
                ],
              ),


            ],
          ),
        )

    );

    // show the dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }




  void resetCameraValues() async {
    _currentZoomLevel = 1.0;
    _currentExposureOffset = 0.0;
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
      if (mounted) setState(() {});
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

      _currentFlashMode = controller!.value.flashMode;
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
    SystemChrome.setEnabledSystemUIOverlays([]);
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

        child: WillPopScope(
        onWillPop:  () async {

        count++;
        if(count==1){





        // showaip(context);


        }
        if(count==2){


        }
        else{
        // Toast.show('Back button press'+count.toString(), context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
        }
        // Do something here
        print("After clicking the Android Back Button");

        return false;
        },
        child:
        Scaffold(
          appBar: AppBar(
            title: Text('Front Camera Screen',style: GoogleFonts.gruppo(fontSize: 28,color: Colors.white,fontWeight: FontWeight.bold)),
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

                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                            16.0,
                            8.0,
                            16.0,
                            8.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black87,
                                    borderRadius:
                                    BorderRadius.circular(10.0),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xFF000000),
                                        borderRadius: BorderRadius.circular(8),
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
                                    child:  DropdownButton<ResolutionPreset>(
                                      dropdownColor: Colors.black87,
                                      underline: Container(),
                                      value: currentResolutionPreset,
                                      items: [
                                        for (ResolutionPreset preset
                                        in resolutionPresets)
                                          DropdownMenuItem(
                                            child: Text(
                                              preset
                                                  .toString()
                                                  .split('.')[1]
                                                  .toUpperCase(),
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            value: preset,
                                          )
                                      ],
                                      onChanged: (value) {
                                        setState(() {
                                          currentResolutionPreset = value!;
                                          _isCameraInitialized = false;
                                        });
                                        onNewCameraSelected(
                                            controller!.description);
                                      },
                                      hint: Text("Select item"),
                                    ),
                                  )
                                ),
                              ),
                              // Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 8.0, top: 16.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                    BorderRadius.circular(10.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      _currentExposureOffset
                                          .toStringAsFixed(1) +
                                          'x',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: RotatedBox(
                                  quarterTurns: 3,
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

                                    height: 30,
                                    child: Slider(
                                      value: _currentExposureOffset,
                                      min: _minAvailableExposureOffset,
                                      max: _maxAvailableExposureOffset,
                                      activeColor: Colors.white,
                                      inactiveColor: Colors.white30,
                                      onChanged: (value) async {
                                        setState(() {
                                          _currentExposureOffset = value;
                                        });
                                        await controller!
                                            .setExposureOffset(value);
                                      },
                                    ),
                                  ),
                                ),
                              ),
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
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(right: 8.0),
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

                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          _currentZoomLevel
                                              .toStringAsFixed(1) +
                                              'x',
                                          style: TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [



                                  InkWell(
                                    onTap: () {
                                      print('clicked');
                                      globals.dialogloading=false;

                                      takePicture(context);




                                    }, // Handle your onTap
                                    child:Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        globals.dialogloading?Icon(Icons.circle,color: Colors.white,size: 80,):
                                        TweenAnimationBuilder<double>(
                                          tween: Tween<double>(begin: 0.0, end: 1),
                                          duration: const Duration(seconds: 3),
                                          builder: (context, value, _) => Stack(
                                            alignment: Alignment.center,
                                            children: [

                                              Container(

                                                child: Text('Wait',style: GoogleFonts.gruppo(fontSize: 28,color: Colors.white,fontWeight: FontWeight.bold)),
                                              ),

                                              Container(

                                                height: 80,
                                                width: 80,

                                                child:  CircularProgressIndicator(

                                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
                                                  strokeWidth: 5.7,
                                                  value: value,
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                        //Text('Wait',style: GoogleFonts.gruppo(fontSize: 80,color: Colors.red,fontWeight: FontWeight.bold)),

                                      ],
                                    )

                                  ),


                                ],
                              ),

                            ],
                          ),
                        ),
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
        )
      );

  }

}

