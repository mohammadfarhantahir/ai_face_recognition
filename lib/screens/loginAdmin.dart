

import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:io';
import '../api/adminLoginapi.dart';

import '../utils/dialogAlerts.dart';
import 'dart:async';


import 'package:camera/camera.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:ai_face/const/globals.dart' as globals;

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../main.dart';
import 'adminDashboard.dart';
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
class loginAdmin extends StatefulWidget{

  State<loginAdmin> createState()=> loginAdminState();

}

class loginAdminState extends State<loginAdmin>{
  CameraController? controller;

  FlutterTts ftts = FlutterTts();
  Timer? timer1;
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

  ResolutionPreset currentResolutionPreset = ResolutionPreset.low;

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


  addadminloginauto() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('admin', nameofface);
    });
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

        camPrevstatus = true;




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

      setState(()  {
        nameofface = s;
        //your custom configuration
       if(nameofface==globals.adminusername){
         print('can go to dashboard');
         camPrevstatus = true;
         addadminloginauto();
         movetoadmindashboard(context);
       }
       else{
         print('user not authenticated');
         camPrevstatus = true;
         dialogAlertslforAdminlogin(context);
       }

      });
      globals.facedetailnameid = nameofface;
      globals.verifiedName = vaa1.toString();
      if(nameofface=='unknown'){
        setState(() {
          nameofface = "Unknown";
          camPrevstatus = true;



        });
      }
      else if(nameofface=='[]'){
        print('no face found');

        setState(() {
          nameofface = "No Face Detected";
          camPrevstatus = true;

        });


      }
      else{

        facestatusknownUnknow = true;
      }

      print("--->"+_rere);


      setState(() {
        camPrevstatus = true;

        var now = new DateTime.now();
        final updatedCurrentTime1 = DateFormat.jm().format(now);








        print(responseString);
      });


    }












    return res.reasonPhrase;
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
  void movetoadmindashboard(BuildContext context){
    /*Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
          builder: (context) => adminDashboard()
      ),
      ModalRoute.withName("/adminDashboard")
  );*/
    if(mounted){
      controller?.dispose();
    }


    Navigator.pushNamed(context, '/adminDashboard');

  }

  @override
  void dispose() {
    timer1?.cancel();
    controller?.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black87,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.settings,
            ),
            // the method which is called
            // when button is pressed
            onPressed: () {
              setState(
                    () {
                  dialogAlertslforloginsetup(context);
                  print('url setting clicked');
                },
              );
            },
          ),
        ],
      ),
      body: _isCameraPermissionGranted
          ? _isCameraInitialized
          ? SingleChildScrollView(
        child:
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

          margin: EdgeInsets.all(10) ,
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child:   Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
               Center(
                 child:  Text('Admin Login',style: GoogleFonts.gruppo(fontSize: 28,color: Colors.white,fontWeight: FontWeight.bold),),
               ),
                AspectRatio(
                  aspectRatio: 0.9 / controller!.value.aspectRatio,
                  child: Stack(

                    children: [



                      Center(
                        child: ClipOval(

                          child: Container(
                            height: MediaQuery.of(context).size.height/2.4,
                            width: MediaQuery.of(context).size.width/1.2,
                            decoration: BoxDecoration(
                              color: Color(0xFF000000),

                              shape: BoxShape.circle,
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
                            child:  camPrevstatus?CameraPreview(
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
                            ):Center(

                          child: Image.asset(
                          'assets/images/circle_glowing.gif',
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                          ),)





                        )

                 ),
                      ),





                    ],
                  ),
                ),
                Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width/2,
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
                    child: Shimmer.fromColors(
                        baseColor: Colors.black,
                        highlightColor: Colors.white,
                        child:  Center(
                            child: InkWell(
                                onTap: () async {

                                  print("tapped");

                                  Socket.connect(globals.readIPURL, 80, timeout: Duration(seconds: 5)).then((socket){

                                    setState(() {
                                      print('php i.p is ---->'+globals.readIPURL!);
                                      camPrevstatus = false;
                                      takePicture().then((value) =>

                                          Apiofcheckfolder().adminLoginModel()

                                      );

                                      print("Success");
                                    });


                                    socket.destroy();
                                  }).catchError((error) {
                                    setState(() {
                                      dialogAlertslforiperror(
                                          context);
                                      print("Exception on Socket " +
                                          error.toString());
                                    });
                                  });


                                },
                                child:  Text('Let\'s Start',style: GoogleFonts.gruppo(fontSize: 28,color: Colors.white,fontWeight: FontWeight.bold),
                                )



                            )
                        )
                    )
                )

              ],
            ),
          )

      )

    ): Center(
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
    );
  }


}

